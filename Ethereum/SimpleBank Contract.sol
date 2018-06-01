pragma solidity ^0.4.16;
// This bank contract allows deposits, withdrawals, and checking the balance
// 'contract' is a keyword to declare class similar to any other OOP
contract SimpleBank {
    // 'mapping' is a dictionary that maps address objects to balances
    // 'private' means that other contracts can't directly query balances
    mapping (address => uint) private balances;

    // 'public' makes externally readable by users or contracts on the blockchain
    address public owner;

    // Events trigger messages throughout the Ethereum network
    event LogDepositMade(address accountAddress, uint amount);

    // Constructor
    function SimpleBank() {
        // msg provides details about the message that's sent to the contract
        // msg.sender is the address of contract creator
        owner = msg.sender;
    }

    // Deposit Ether into the bank
    // Returns the balance of the user after a deposit is made
    function deposit() public returns (uint) {
        // Add the value being deposited to the account balance
        balances[msg.sender] += msg.value;

        // Log the deposit that was just made
        LogDepositMade(msg.sender, msg.value);
        // Return the balance after the deposit
        return balances[msg.sender];
    }

    // Withdraw Ether from bank
    // withdrawAmount is the amount you want to withdraw
    // Returns the balance remaining for the user
    function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
        /* If the account balance is greater than amount requested for withdrawal, subtract it from
        the balance */
        if (balances[msg.sender] >= withdrawAmount) {
            balances[msg.sender] -= withdrawAmount;
            // Increment the balance back to the original account on fail
            if (!msg.sender.send(withdrawAmount)) {
                    balances[msg.sender] += withdrawAmount;
            }
        }

        // Return the remaining balance after withdrawal
        return balances[msg.sender];
    }

    // Return the balance of the user
    // 'constant' prevents function from editing state variables;
    function balance() constant returns (uint) {
        return balances[msg.sender];
        }
}