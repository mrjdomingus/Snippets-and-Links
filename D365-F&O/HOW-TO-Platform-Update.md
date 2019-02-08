# Some tips re: Platform update in local VM DEV BOX

* Download deployable package (from PEAP Assets LCS Project or LCS Shared Asset Library.

* Follow procedure as described in [https://docs.microsoft.com/en-us/dynamics365/unified-operations/dev-itpro/migration-upgrade/upgrade-latest-platform-update](https://docs.microsoft.com/en-us/dynamics365/unified-operations/dev-itpro/migration-upgrade/upgrade-latest-platform-update) and [https://docs.microsoft.com/en-us/dynamics365/unified-operations/dev-itpro/deployment/install-deployable-package](https://docs.microsoft.com/en-us/dynamics365/unified-operations/dev-itpro/deployment/install-deployable-package) as applicable.

  This will involve:
  * Update of file  **DefaultTopologyData.xml**
  * Generate a runbook, i.e. `AXUpdateInstaller.exe generate -runbookid="my-runbook" -topologyfile="DefaultTopologyData.xml" -servicemodelfile="DefaultServiceModelData.xml" -runbookfile="my-runbook.xml"`
  * Import the runbook, i.e. `AXUpdateInstaller.exe import -runbookfile="my-runbook.xml"`
  * Run (execute) the runbook, i.e. `AXUpdateInstaller.exe execute -runbookid="my-runbook"`

  **NOTES**
  * First tune the VM for optimal performance.
  * You will have to bypass most if not all steps involving LCS.
  * To manually set a runbook step as completed, use: `AXUpdateInstaller.exe execute -runbookid="my-runbook" -setstepcomplete=<stepno>`
  * To rerun a specific runbook step, use: `AXUpdateInstaller.exe execute -runbookid="my-runbook" -rerunstep=<stepno>`
  * If Database Sync fails when executing the runbook, try to sync the AX database from within Visual Studio or use the `SyncEngine.exe` in folder `C:\AOSService\PackagesLocalDirectory\Bin`.
  * If a runbook step appears to hang for too long, press [Enter] in the CMD window as this may unstuck the step.

## Workaround for the Visual Studio Professional expired license issue

This isue may arise when you try to acquire an updated VS 2015 Pro license which fails because your AD account also exists in a 3rd-party tenant (for instance Ultimaker) with MFA enabled.

To work around this:
* Install Fiddler v5
* First try the failing attempt to update the license and log this via Fiddler
* Use the AutResponder functionality to intercept the call to `https://app.vssps.visualstudio.com/_apis/identities/me` and change the original response to include only your actual home tenant.
* Retry to update the license, this should now succeed as it will only try to authenticate you at your home tenant.

