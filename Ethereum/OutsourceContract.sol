pragma solidity ^0.4.11;

// PAEMD d.d. 2018-01-28
// Contract to handle outsourcing within discrete manufacturing
// Version 0.11 (this is alpha code!)


contract AccessRestriction {
    // These will be assigned at the construction
    // phase, where `msg.sender` is the account
    // creating this contract.
    address public owner = msg.sender;
    uint public creationTime = now;

    // Modifiers can be used to change
    // the body of a function.
    // If this modifier is used, it will
    // prepend a check that only passes
    // if the function is called from
    // a certain address.
    modifier onlyBy(address _account)
    {
        require(msg.sender == _account);
        // Do not forget the "_;"! It will
        // be replaced by the actual function
        // body when the modifier is used.
        _;
    }

    /// Make `_newOwner` the new owner of this
    /// contract.
    function changeOwner(address _newOwner) public onlyBy(owner) {
        owner = _newOwner;
    }

    modifier onlyAfter(uint _time) {
        require(now >= _time);
        _;
    }

    /// Erase ownership information.
    /// May only be called 6 weeks after
    /// the contract has been created.
    function disown() public onlyBy(owner) onlyAfter(creationTime + 6 weeks) {
        delete owner;
    }

}

contract OutsourceContract is AccessRestriction {
    string ipfsHash;
    address shipper;
    address outsourcee;
    
    enum State { Created, Opened, Accepted, WorkInProgress, WorkCompleted, Finished }
    enum Location { AtOwner, AtOutsourcee, InTransit }
    State public state;
    Location public location;

    event DeliveryEvent(
        string  _extraMsg,
        address  indexed _recipient
    );

    event WorkUpdate(
        string  _extraMsg,
        address  indexed _from,
        address  indexed _contract
    );    

    modifier onlyByShipperOrOutsourcee()
    {
        require((msg.sender == shipper) || (msg.sender == outsourcee));
        // Do not forget the "_;"! It will
        // be replaced by the actual function
        // body when the modifier is used.
        _;
    }
    
    modifier onlyByOwnerOrOutsourcee()
    {
        require((msg.sender == owner) || (msg.sender == outsourcee));
        // Do not forget the "_;"! It will
        // be replaced by the actual function
        // body when the modifier is used.
        _;
    }
    
    // Constructor
    function OutsourceContract(string _ipfsHash) public { 
        ipfsHash = _ipfsHash; 
        state = State.Created;
        location = Location.AtOwner;
    }

    // Assign address of designated shipper
    function assignShipper(address _shipper) public onlyBy(owner) {
        shipper = _shipper;
    }
    
    // Assign address of designated oursourcee
    function assignOutsourcee(address _outsourcee) public onlyBy(owner) {
        outsourcee = _outsourcee;
    }
    
    // Retrieve IPFS hash of contract documentation
    function getIpfsHash() public constant onlyByShipperOrOutsourcee returns (string) {
        return ipfsHash;
    }
    
    // Confirm delivery at one of two valid locations
    function deliveredAt() public onlyByOwnerOrOutsourcee {
        if ( msg.sender == owner) {
            location = Location.AtOwner;
        } else {
            location = Location.AtOutsourcee;
        }
        DeliveryEvent("Shipment delivered at ...", msg.sender);
    }
    
    // Confirm pick up by shipper
    function pickedUp() public onlyBy(shipper) {
        location = Location.InTransit;
        DeliveryEvent("Shipment picked up by...", msg.sender);
    }
    // Retrieve state of contract
    function getState() public constant returns (State) {
        return state;
    }
    
    // Retrieve location of shipment
    function getLocation() public constant returns (Location) {
        return location;
    }  
        
    // Contract is read (by outsourcee)
    function contractOpened() public onlyBy(outsourcee) {
        state = State.Opened;
    }

    // Contract is read (by outsourcee)
    function contractAccepted() public onlyBy(outsourcee) {
        state = State.Accepted;
    }

    function workStarted() public onlyBy(outsourcee) {
        state = State.WorkInProgress;
        WorkUpdate("Work has started...", outsourcee, address(this));
    }
    
    function workCompleted() public onlyBy(outsourcee) {
        state = State.WorkCompleted;
        WorkUpdate("Work has completed!", outsourcee, address(this));
    }
    
    function contractFinished() public onlyBy(owner) {
        state = State.Finished;
        WorkUpdate("Contract has finished!", owner, address(this));
    }
}