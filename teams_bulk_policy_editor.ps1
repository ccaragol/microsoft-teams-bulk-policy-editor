<# 
.Synopsis 
   The purpose of this tool is to give you an easy front end for the management of Teams Policies in
   bulk.  I imagine this may someday be built into the GUI, but until then I hope it helps you out.
 
.DESCRIPTION 
   PowerShell GUI script which allows for GUI management of Teams Policies
 
.Notes 
     NAME:      teams_bulk_policy_editor.ps1
     VERSION:   1.0
     AUTHOR:    C. Anthony Caragol 
     LASTEDIT:  03/07/2018 
      
   V 1.0 - March 7th 2018 - Initial release 
	    
.Link 
   Website: http://www.teamsadmin.com
   Twitter: http://www.twitter.com/canthonycaragol
   LinkedIn: http://www.linkedin.com/in/canthonycaragol
 
.EXAMPLE 
   .\teams_bulk_policy_editor.ps1 

.TODO
    Add a way to add a member\owner to selected teams


.APOLOGY
  Please excuse the sloppy coding, I don't use a development environment, IDE or ISE.  I use notepad, 
  not even Notepad++, just notepad.  I am not a developer, just an enthusiast so some code may be redundant or
  inefficient.
#>


$Global:TeamsAdminIcon = [System.Convert]::FromBase64String('
AAABAAEAJiEAAAEACABYCgAAFgAAACgAAAAmAAAAQgAAAAEACAAAAAAAKAUAAAAAAAAAAAAAAAEAAAAB
AAAAAAAAMwAAAGYAAACZAAAAzAAAAP8AAAAAKwAAMysAAGYrAACZKwAAzCsAAP8rAAAAVQAAM1UAAGZV
AACZVQAAzFUAAP9VAAAAgAAAM4AAAGaAAACZgAAAzIAAAP+AAAAAqgAAM6oAAGaqAACZqgAAzKoAAP+q
AAAA1QAAM9UAAGbVAACZ1QAAzNUAAP/VAAAA/wAAM/8AAGb/AACZ/wAAzP8AAP//AAAAADMAMwAzAGYA
MwCZADMAzAAzAP8AMwAAKzMAMyszAGYrMwCZKzMAzCszAP8rMwAAVTMAM1UzAGZVMwCZVTMAzFUzAP9V
MwAAgDMAM4AzAGaAMwCZgDMAzIAzAP+AMwAAqjMAM6ozAGaqMwCZqjMAzKozAP+qMwAA1TMAM9UzAGbV
MwCZ1TMAzNUzAP/VMwAA/zMAM/8zAGb/MwCZ/zMAzP8zAP//MwAAAGYAMwBmAGYAZgCZAGYAzABmAP8A
ZgAAK2YAMytmAGYrZgCZK2YAzCtmAP8rZgAAVWYAM1VmAGZVZgCZVWYAzFVmAP9VZgAAgGYAM4BmAGaA
ZgCZgGYAzIBmAP+AZgAAqmYAM6pmAGaqZgCZqmYAzKpmAP+qZgAA1WYAM9VmAGbVZgCZ1WYAzNVmAP/V
ZgAA/2YAM/9mAGb/ZgCZ/2YAzP9mAP//ZgAAAJkAMwCZAGYAmQCZAJkAzACZAP8AmQAAK5kAMyuZAGYr
mQCZK5kAzCuZAP8rmQAAVZkAM1WZAGZVmQCZVZkAzFWZAP9VmQAAgJkAM4CZAGaAmQCZgJkAzICZAP+A
mQAAqpkAM6qZAGaqmQCZqpkAzKqZAP+qmQAA1ZkAM9WZAGbVmQCZ1ZkAzNWZAP/VmQAA/5kAM/+ZAGb/
mQCZ/5kAzP+ZAP//mQAAAMwAMwDMAGYAzACZAMwAzADMAP8AzAAAK8wAMyvMAGYrzACZK8wAzCvMAP8r
zAAAVcwAM1XMAGZVzACZVcwAzFXMAP9VzAAAgMwAM4DMAGaAzACZgMwAzIDMAP+AzAAAqswAM6rMAGaq
zACZqswAzKrMAP+qzAAA1cwAM9XMAGbVzACZ1cwAzNXMAP/VzAAA/8wAM//MAGb/zACZ/8wAzP/MAP//
zAAAAP8AMwD/AGYA/wCZAP8AzAD/AP8A/wAAK/8AMyv/AGYr/wCZK/8AzCv/AP8r/wAAVf8AM1X/AGZV
/wCZVf8AzFX/AP9V/wAAgP8AM4D/AGaA/wCZgP8AzID/AP+A/wAAqv8AM6r/AGaq/wCZqv8AzKr/AP+q
/wAA1f8AM9X/AGbV/wCZ1f8AzNX/AP/V/wAA//8AM///AGb//wCZ//8AzP//AP///wAAAAAAAAAAAAAA
AAAAAAAAHB0WHRwdHRwXHRwdHRwdHB0cFx0cHRwXHRwdHRwdHB0dFh0dHB0AAB0cHRwXHB0WHRwXHB0W
HRYdHB0cFxwXHB0WHRwXHBccHRwdFh0cAAAcHRYdHB0cHRwdHB0cHRwdHB0WHRwdHB0cHRwdHB0cHRwX
HB0cHQAAHRwdHBcdFh0cFxwdFh0XHB0dHB0WHRwXHBccFxwdFh0cHRwXHB0AAB0cFxwdHB0cHR0cHR0c
HRwdHBccHR0cHR0cHR0cHR0cHRccHRwdAAAdHB0dFh0cFxwXHBccFxwdFh0cHRYdFh0cFxwdFh0WHRwd
HBccHQAAHRwXHB0cHRwdHB0cHRwdHB0WHRwdHB0cHRwdHB0cHRwdFh0dHB0AAB0cHRwXHBccHRwXHB0c
Fx0cHRwXHB0cFxwXHRYdHBccHRwdFh0cAAAdHBccHRwdHBccHRwXHB0cHRYdHB0WHRwdHB0cHRwdHRwX
HB0cHQAAHRwdd/v7+/v7+/v7+/v7mh3R+/v7+/v1HBccHRYdHB0cHRwXHB0AAB0WHSL7+/v7+/v7+/v7
+/UcTfv7+/v7+3AdHB0dFh0WHRccHRwdAAAdHB0X0fv7+/v7+/v7+/v7mh3R+/v7+/uaHRYdHB0cHRwd
HBccHQAAFh0cHU37+/v7+/v7+/v7+/Udp/v7+/v7yxwdHB0cFxwdFh0dFh0AAB0cFxwd0fv7+/v7+/v7
+/v7cB37+/v7+/tAHRYdHB0dHB0cHRwdAAAdHB0cF6f7+/v7+8oXHB0cHR0c0fv7+/v7+/v7+/vEHRwd
Fh0cHQAAHRYdHRxN+/v7+/v1HB0XHB0WHXf7+/v7+/v7+/v79BccFxwdFxwAAB0cHRwXHNH7+/v7+3Ad
HB0cHRwd+/v7+/v7+/v7+/tHHB0cHRwdAAAdFh0cHR2n+/v7+/ubHB0WHRwdHdH7+/v7+/v7+/v7xB0c
HRYdHAAAHRwdHB0cTfv7+/v79B0cHRwdFh13+/v7+/v7+/v7+/UdFh0dHB0AAB0cHRccFx37+/v7+/tw
HRwXHB0cHfv7+/v7+0YdHB0cHRwcHRwXAAAcFxwdHB0c0fv7+/v7xRYdHRwdHB3R+/v7+/v7+/v7+/vF
HRYdHAAAHRwdFh0cHXf7+/v7+/tHHB0WHRccd/v7+/v7+/v7+/v79B0cHR0AABccHRwdFh0d+/v7+/v7
mhccHRwdHE37+/v7+/v7+/v7+/UdHBccAAAdHBcdHB0cHdH7+/v7+8scHRYdHB0d0fv7+/v7+/v7+/v7
cB0cHQAAHB0cHRwdFh13+/v7+/v7ah0dHB0WHaH7+/v7+/v7+/v7+8UcHR0AAB0cFxwXHB0cHRwdFh0c
HRwdHBccHRwdHB0WHRwXHB0cHRwXHBccAAAWHRwdHB0dHB0WHRwdHRwdFh0cHRwdHRYdHB0cHR0WHRYd
HB0cHQAAHRwXHB0cFxwXHB0WHRYdFh0cFxwXHBccHRYdFh0cHRwdHBccHRwAAB0cHR0WHRwdHRwdHRwd
HB0dHB0dHB0cHR0cHR0cHRwdFxwdFxwdAAAdFh0cHRwXHB0WHRwdFh0cFxwdHBccHRYdHB0WHRwXHB0c
HRwdHAAAHB0cHRYdHB0cHRwXHB0cHRwdFh0cHRwdHBccHRwdHB0WHRwdFh0AAB0cFxwdHBccHRYdHB0W
HRwXHB0cFxwdFh0cHRYdHBccHRwXHB0cAAAcHR0cHR0cHR0cHR0cHR0cHR0cHR0cHR0cHR0cHR0cHR0c
HR0cHQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
')


Function CheckForInstalledModules
{
    #Save-Module -Name MicrosoftTeams -Path . -RequiredVersion 0.9.0
    #Install-Module -Name MicrosoftTeams -RequiredVersion 0.9.0
    if (-not(get-module -ListAvailable "MicrosoftTeams")) {
        [Microsoft.VisualBasic.Interaction]::MsgBox("Microsoft Teams PowerShell Module Not Found.  Please run 'Install-Module -Name MicrosoftTeams' before continuing if you have not done so." ,'OKOnly,Information', "Teams PowerShell Module Not Installed!")
    }
}

Function MainForm()
{
	
    $mainForm = New-Object System.Windows.Forms.Form 
    $mainForm.Text = "Microsoft Teams Bulk Policy Tool"
    $mainForm.Size = New-Object System.Drawing.Size(880,600) 
    $mainForm.MinimumSize = New-Object System.Drawing.Size(880,600) 
    $mainForm.StartPosition = "CenterScreen"
    $mainForm.Add_SizeChanged($CAC_FormSizeChanged)
    $mainForm.KeyPreview = $True
    $mainForm.Icon = $Global:TeamsAdminIcon

    $TitleLabel = New-Object System.Windows.Forms.Label
    $TitleLabel.Location = New-Object System.Drawing.Size(10,10) 
    $TitleLabel.Size = New-Object System.Drawing.Size(780,30) 
    $TitleLabel.Text = "The purpose of this tool is to give you an interim front end for working with Microsoft Teams settings in bulk."
    $mainForm.Controls.Add($TitleLabel) 

    $TitleLabel2 = New-Object System.Windows.Forms.Label
    $TitleLabel2.Location = New-Object System.Drawing.Size(10,40) 
    $TitleLabel2.Size = New-Object System.Drawing.Size(780,30) 
    $TitleLabel2.ForeColor = [System.Drawing.Color]::Red
    $TitleLabel2.Text = "Warning: Changes may take time to take effect across your tenant."
    $mainForm.Controls.Add($TitleLabel2) 

    $TeamsListBox = New-Object System.Windows.Forms.ListBox 
    $TeamsListBox.Location = New-Object System.Drawing.Size(10,80) 
    $TeamsListBox.Size = New-Object System.Drawing.Size(300,420) 
    $TeamsListBox.Anchor = 'Top, Bottom,Left'
    $TeamsListBox.Sorted = $True
    $TeamsListBox.SelectionMode = "MultiExtended"
    $TeamsListBox.add_SelectedIndexChanged({
	    if ($TeamsListBox.SelectedItems.count -gt 1)
	    {
            $AllowUserEditLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowUserEditCheckboxon.checked=$false
            $AllowUserEditCheckboxoff.checked=$false
            $AllowUserDeleteLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowUserDeleteCheckboxon.checked=$false
            $AllowUserDeleteCheckboxoff.checked=$false
            $AllowOWnerDeleteLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowOwnerDeleteCheckboxon.checked=$false
            $AllowOwnerDeleteCheckboxoff.checked=$false
            $AllowTeamMentionsLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowTeamMentionsCheckboxon.checked=$false
            $AllowTeamMentionsCheckboxoff.checked=$false
            $AllowChannelMentionsLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowChannelMentionsCheckboxon.checked=$false
            $AllowChannelMentionsCheckboxoff.checked=$false
            $AllowCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowCreateUpdateChannelsCheckboxon.checked=$false
            $AllowCreateUpdateChannelsCheckboxoff.checked=$false
            $AllowDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowDeleteChannelsCheckboxon.checked=$false
            $AllowDeleteChannelsCheckboxoff.checked=$false
            $AllowAddRemoveAppsLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowAddRemoveAppsCheckboxon.checked=$false
            $AllowAddRemoveAppsCheckboxoff.checked=$false
            $AllowCreateUpdateRemoveTabsLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowCreateUpdateRemoveTabsCheckboxon.checked=$false
            $AllowCreateUpdateRemoveTabsCheckboxoff.checked=$false
            $AllowCreateUpdateRemoveConnectorsLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowCreateUpdateRemoveConnectorsCheckboxon.checked=$false
            $AllowCreateUpdateRemoveConnectorsCheckboxoff.checked=$false
            $AllowGuestCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowGuestCreateUpdateChannelsCheckboxon.checked=$false
            $AllowGuestCreateUpdateChannelsCheckboxoff.checked=$false
            $AllowGuestDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowGuestDeleteChannelsCheckboxon.checked=$false
            $AllowGuestDeleteChannelsCheckboxoff.checked=$false
            $AllowAllowStickersMemesLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowAllowStickersMemesCheckboxon.checked=$false
            $AllowAllowStickersMemesCheckboxoff.checked=$false
            $AllowAllowCustomMemesLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowAllowCustomMemesCheckboxon.checked=$false
            $AllowAllowCustomMemesCheckboxoff.checked=$false
            $AllowGiphyLabel.ForeColor = [System.Drawing.Color]::Black
            $AllowGiphyCheckboxon.checked=$false
            $AllowGiphyCheckboxoff.checked=$false
            $GiphyContentRatingLabel.ForeColor = [System.Drawing.Color]::Black
            $GiphyContentRatingDropdown.SelectedIndex=0
	    }
	    else
	    {
            $ApplyChangesToTeamsButton.enabled=$False
            $team=get-team |where {$_.displayname -eq $TeamsListBox.SelectedItem.tostring()}
            $teamfun=Get-TeamFunSettings -groupid $team.groupid
            $teamguest=Get-TeamGuestSettings -groupid $team.groupid
            $teamMember=Get-TeamMemberSettings -groupid $team.groupid
            $teamMessaging=Get-TeamMessagingSettings -groupid $team.groupid

            if ($teammessaging.AllowUserEditMessages) {$AllowUserEditCheckboxon.checked=$true} Else {$AllowUserEditCheckboxoff.checked=$true}
            $AllowUserEditLabel.ForeColor = [System.Drawing.Color]::Black
  
            if ($teammessaging.AllowUserDeleteMessages) {$AllowUserDeleteCheckboxon.checked=$true} Else {$AllowUserDeleteCheckboxoff.checked=$true}
            $AllowUserDeleteLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teammessaging.AllowOwnerDeleteMessages) {$AllowOwnerDeleteCheckboxon.checked=$true} Else {$AllowOwnerDeleteCheckboxoff.checked=$true}
            $AllowOWnerDeleteLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teammessaging.AllowTeamMentions) {$AllowTeamMentionsCheckboxon.checked=$true} Else {$AllowTeamMentionsCheckboxoff.checked=$true}
            $AllowTeamMentionsLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teammessaging.AllowChannelMentions) {$AllowChannelMentionsCheckboxon.checked=$true} Else {$AllowChannelMentionsCheckboxoff.checked=$true}
            $AllowChannelMentionsLabel.ForeColor = [System.Drawing.Color]::Black
  
            if ($teammember.AllowCreateUpdateChannels) {$AllowCreateUpdateChannelsCheckboxon.checked=$true} Else {$AllowCreateUpdateChannelsCheckboxoff.checked=$true}
            $AllowCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teammember.AllowDeleteChannels) {$AllowDeleteChannelsCheckboxon.checked=$true} Else {$AllowDeleteChannelsCheckboxoff.checked=$true}
            $AllowDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teammember.AllowAddRemoveApps) {$AllowAddRemoveAppsCheckboxon.checked=$true} Else {$AllowAddRemoveAppsCheckboxoff.checked=$true}
            $AllowAddRemoveAppsLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teammember.AllowCreateUpdateRemoveTabs) {$AllowCreateUpdateRemoveTabsCheckboxon.checked=$true} Else {$AllowCreateUpdateRemoveTabsCheckboxoff.checked=$true}
            $AllowCreateUpdateRemoveTabsLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teammember.AllowCreateUpdateRemoveConnectors) {$AllowCreateUpdateRemoveConnectorsCheckboxon.checked=$true} Else {$AllowCreateUpdateRemoveConnectorsCheckboxoff.checked=$true}
            $AllowCreateUpdateRemoveConnectorsLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teamguest.AllowCreateUpdateChannels) {$AllowGuestCreateUpdateChannelsCheckboxon.checked=$true} Else {$AllowGuestCreateUpdateChannelsCheckboxoff.checked=$true}
            $AllowGuestCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teamguest.AllowDeleteChannels) {$AllowGuestDeleteChannelsCheckboxon.checked=$true} Else {$AllowGuestDeleteChannelsCheckboxoff.checked=$true}
            $AllowGuestDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teamfun.AllowStickersAndMemes) {$AllowAllowStickersMemesCheckboxon.checked=$true} Else {$AllowAllowStickersMemesCheckboxoff.checked=$true}
            $AllowAllowStickersMemesLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teamfun.AllowCustomMemes) {$AllowAllowCustomMemesCheckboxon.checked=$true} Else {$AllowAllowCustomMemesCheckboxoff.checked=$true}
            $AllowAllowCustomMemesLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teamfun.AllowGiphy) {$AllowGiphyCheckboxon.checked=$true} Else {$AllowGiphyCheckboxoff.checked=$true}
            $AllowGiphyLabel.ForeColor = [System.Drawing.Color]::Black

            if ($teamfun.GiphyContentRating -eq "moderate") {$GiphyContentRatingDropdown.SelectedIndex=2} Else {$GiphyContentRatingDropdown.SelectedIndex=1}
            $GiphyContentRatingLabel.ForeColor = [System.Drawing.Color]::Black
    
            $ApplyChangesToTeamsButton.Enabled=$true
	    }
    })
    $mainForm.Controls.Add($TeamsListBox) 

    $CheckboxHeightSpacing=25
    $CheckboxStartHeight=80
    $CheckboxTextWidth=280

    $AllowUserEditLabel = New-Object System.Windows.Forms.Label
    $AllowUserEditLabel.Location = New-Object System.Drawing.Size(320,$CheckboxStartHeight) 
    $AllowUserEditLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowUserEditLabel.Text = "Allow Users To Edit Messages"
    $mainForm.Controls.Add($AllowUserEditLabel) 

    $AllowUserEditCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowUserEditCheckboxon.UseVisualStyleBackColor = $True
    $AllowUserEditCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowUserEditCheckboxon.TabIndex = 1
    $AllowUserEditCheckboxon.Text = "True"
    $AllowUserEditCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),$CheckboxStartHeight) 
    $AllowUserEditCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowUserEditCheckboxon.Name = "AllowUserEditCheckboxon"
    $AllowUserEditCheckboxon.Add_CheckStateChanged({
    if ($AllowUserEditCheckboxon.Checked) {$AllowUserEditCheckboxoff.checked=$false}
    if ($AllowUserEditCheckboxon.Checked -or $AllowUserEditCheckboxoff.Checked) 
        {	
            $AllowUserEditLabel.ForeColor = [System.Drawing.Color]::Green
        } 
        Else  
        {	
            $AllowUserEditLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowUserEditCheckboxon)

    $AllowUserEditCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowUserEditCheckboxoff.UseVisualStyleBackColor = $True
    $AllowUserEditCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowUserEditCheckboxoff.TabIndex = 1
    $AllowUserEditCheckboxoff.Text = "False"
    $AllowUserEditCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),$CheckboxStartHeight) 
    $AllowUserEditCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowUserEditCheckboxoff.Name = "AllowUserEditCheckboxoff"
    $AllowUserEditCheckboxoff.Add_CheckStateChanged({
    if ($AllowUserEditCheckboxoff.Checked) {$AllowUserEditCheckboxon.checked=$false}
    if ($AllowUserEditCheckboxon.Checked -or $AllowUserEditCheckboxoff.Checked) 
        {	
            $AllowUserEditLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowUserEditLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowUserEditCheckboxoff)

    $AllowUserDeleteLabel = New-Object System.Windows.Forms.Label
    $AllowUserDeleteLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+$CheckboxHeightSpacing)) 
    $AllowUserDeleteLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowUserDeleteLabel.Text = "Allow Users To Delete Messages"
    $mainForm.Controls.Add($AllowUserDeleteLabel) 

    $AllowUserDeleteCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowUserDeleteCheckboxon.UseVisualStyleBackColor = $True
    $AllowUserDeleteCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowUserDeleteCheckboxon.TabIndex = 1
    $AllowUserDeleteCheckboxon.Text = "True"
    $AllowUserDeleteCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+$CheckboxHeightSpacing)) 
    $AllowUserDeleteCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowUserDeleteCheckboxon.Name = "AllowUserDeleteCheckboxon"
    $AllowUserDeleteCheckboxon.Add_CheckStateChanged({
    if ($AllowUserDeleteCheckboxon.Checked) {$AllowUserDeleteCheckboxoff.checked=$false}
    if ($AllowUserDeleteCheckboxon.Checked -or $AllowUserDeleteCheckboxoff.Checked) 
        {
        	$AllowUserDeleteLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else
        {	
            $AllowUserDeleteLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowUserDeleteCheckboxon)

    $AllowUserDeleteCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowUserDeleteCheckboxoff.UseVisualStyleBackColor = $True
    $AllowUserDeleteCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowUserDeleteCheckboxoff.TabIndex = 1
    $AllowUserDeleteCheckboxoff.Text = "False"
    $AllowUserDeleteCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+$CheckboxHeightSpacing)) 
    $AllowUserDeleteCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowUserDeleteCheckboxoff.Name = "AllowUserDeleteCheckboxoff"
    $AllowUserDeleteCheckboxoff.Add_CheckStateChanged({
    if ($AllowUserDeleteCheckboxoff.Checked) 
        {
            $AllowUserDeleteCheckboxon.checked=$false
        }
    Else  
        {
        	$AllowUserDeleteLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowUserDeleteCheckboxoff)

    $AllowOwnerDeleteLabel = New-Object System.Windows.Forms.Label
    $AllowOwnerDeleteLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*2))) 
    $AllowOwnerDeleteLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowOwnerDeleteLabel.Text = "Allow Owners To Delete Messages"
    $mainForm.Controls.Add($AllowOwnerDeleteLabel) 

    $AllowOwnerDeleteCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowOwnerDeleteCheckboxon.UseVisualStyleBackColor = $True
    $AllowOwnerDeleteCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowOwnerDeleteCheckboxon.TabIndex = 1
    $AllowOwnerDeleteCheckboxon.Text = "True"
    $AllowOwnerDeleteCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*2))) 
    $AllowOwnerDeleteCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowOwnerDeleteCheckboxon.Name = "AllowOwnerDeleteCheckboxon"
    $AllowOwnerDeleteCheckboxon.Add_CheckStateChanged({
    if ($AllowOwnerDeleteCheckboxon.Checked) {$AllowOwnerDeleteCheckboxoff.checked=$false}
    if ($AllowOwnerDeleteCheckboxon.Checked -or $AllowOwnerDeleteCheckboxoff.Checked) {	$AllowOwnerDeleteLabel.ForeColor = [System.Drawing.Color]::Green} 
    Else  {	$AllowOwnerDeleteLabel.ForeColor = [System.Drawing.Color]::Black} 
    })
    $mainForm.Controls.Add($AllowOwnerDeleteCheckboxon)

    $AllowOwnerDeleteCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowOwnerDeleteCheckboxoff.UseVisualStyleBackColor = $True
    $AllowOwnerDeleteCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowOwnerDeleteCheckboxoff.TabIndex = 1
    $AllowOwnerDeleteCheckboxoff.Text = "False"
    $AllowOwnerDeleteCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*2))) 
    $AllowOwnerDeleteCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowOwnerDeleteCheckboxoff.Name = "AllowOwnerDeleteCheckboxoff"
    $AllowOwnerDeleteCheckboxoff.Add_CheckStateChanged({
    if ($AllowOwnerDeleteCheckboxoff.Checked) {$AllowOwnerDeleteCheckboxon.checked=$false}
    if ($AllowOwnerDeleteCheckboxon.Checked -or $AllowOwnerDeleteCheckboxoff.Checked) 
        {
        	$AllowOwnerDeleteLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else
        {
        	$AllowOwnerDeleteLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowOwnerDeleteCheckboxoff)

    $AllowTeamMentionsLabel = New-Object System.Windows.Forms.Label
    $AllowTeamMentionsLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*3))) 
    $AllowTeamMentionsLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowTeamMentionsLabel.Text = "Allow Team Mentions"
    $mainForm.Controls.Add($AllowTeamMentionsLabel) 

    $AllowTeamMentionsCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowTeamMentionsCheckboxon.UseVisualStyleBackColor = $True
    $AllowTeamMentionsCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowTeamMentionsCheckboxon.TabIndex = 1
    $AllowTeamMentionsCheckboxon.Text = "True"
    $AllowTeamMentionsCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*3))) 
    $AllowTeamMentionsCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowTeamMentionsCheckboxon.Name = "AllowOwnerDeleteCheckboxon"
    $AllowTeamMentionsCheckboxon.Add_CheckStateChanged({
    if ($AllowTeamMentionsCheckboxon.Checked) {$AllowTeamMentionsCheckboxoff.checked=$false}
    if ($AllowTeamMentionsCheckboxon.Checked -or $AllowTeamMentionsCheckboxoff.Checked) 
        {
        	$AllowTeamMentionsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else
        {
        	$AllowTeamMentionsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowTeamMentionsCheckboxon)

    $AllowTeamMentionsCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowTeamMentionsCheckboxoff.UseVisualStyleBackColor = $True
    $AllowTeamMentionsCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowTeamMentionsCheckboxoff.TabIndex = 1
    $AllowTeamMentionsCheckboxoff.Text = "False"
    $AllowTeamMentionsCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*3))) 
    $AllowTeamMentionsCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowTeamMentionsCheckboxoff.Name = "AllowOwnerDeleteCheckboxoff"
    $AllowTeamMentionsCheckboxoff.Add_CheckStateChanged({
    if ($AllowTeamMentionsCheckboxoff.Checked) {$AllowTeamMentionsCheckboxon.checked=$false}
    if ($AllowTeamMentionsCheckboxon.Checked -or $AllowTeamMentionsCheckboxoff.Checked)
        {
        	$AllowTeamMentionsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else
        {
        	$AllowTeamMentionsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowTeamMentionsCheckboxoff)

    $AllowChannelMentionsLabel = New-Object System.Windows.Forms.Label
    $AllowChannelMentionsLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*4))) 
    $AllowChannelMentionsLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowChannelMentionsLabel.Text = "Allow Channel Mentions"
    $mainForm.Controls.Add($AllowChannelMentionsLabel) 

    $AllowChannelMentionsCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowChannelMentionsCheckboxon.UseVisualStyleBackColor = $True
    $AllowChannelMentionsCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowChannelMentionsCheckboxon.TabIndex = 1
    $AllowChannelMentionsCheckboxon.Text = "True"
    $AllowChannelMentionsCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*4))) 
    $AllowChannelMentionsCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowChannelMentionsCheckboxon.Name = "AllowOwnerDeleteCheckboxon"
    $AllowChannelMentionsCheckboxon.Add_CheckStateChanged({
    if ($AllowChannelMentionsCheckboxon.Checked) {$AllowChannelMentionsCheckboxoff.checked=$false}
    if ($AllowChannelMentionsCheckboxon.Checked -or $AllowChannelMentionsCheckboxoff.Checked) 
        {
        	$AllowChannelMentionsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else
        {
        	$AllowChannelMentionsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowChannelMentionsCheckboxon)

    $AllowChannelMentionsCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowChannelMentionsCheckboxoff.UseVisualStyleBackColor = $True
    $AllowChannelMentionsCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowChannelMentionsCheckboxoff.TabIndex = 1
    $AllowChannelMentionsCheckboxoff.Text = "False"
    $AllowChannelMentionsCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*4))) 
    $AllowChannelMentionsCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowChannelMentionsCheckboxoff.Name = "AllowOwnerDeleteCheckboxoff"
    $AllowChannelMentionsCheckboxoff.Add_CheckStateChanged({
    if ($AllowChannelMentionsCheckboxoff.Checked) {$AllowChannelMentionsCheckboxon.checked=$false}
    if ($AllowChannelMentionsCheckboxon.Checked -or $AllowChannelMentionsCheckboxoff.Checked)
        {
        	$AllowChannelMentionsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowChannelMentionsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowChannelMentionsCheckboxoff)

    $AllowCreateUpdateChannelsLabel = New-Object System.Windows.Forms.Label
    $AllowCreateUpdateChannelsLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*5))) 
    $AllowCreateUpdateChannelsLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowCreateUpdateChannelsLabel.Text = "Allow Members to Create\Update Channels"
    $mainForm.Controls.Add($AllowCreateUpdateChannelsLabel) 

    $AllowCreateUpdateChannelsCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowCreateUpdateChannelsCheckboxon.UseVisualStyleBackColor = $True
    $AllowCreateUpdateChannelsCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowCreateUpdateChannelsCheckboxon.TabIndex = 1
    $AllowCreateUpdateChannelsCheckboxon.Text = "True"
    $AllowCreateUpdateChannelsCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*5))) 
    $AllowCreateUpdateChannelsCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowCreateUpdateChannelsCheckboxon.Name = "AllowCreateUpdateChannelsCheckboxon"
    $AllowCreateUpdateChannelsCheckboxon.Add_CheckStateChanged({
    if ($AllowCreateUpdateChannelsCheckboxon.Checked) {$AllowCreateUpdateChannelsCheckboxoff.checked=$false}
    if ($AllowCreateUpdateChannelsCheckboxon.Checked -or $AllowCreateUpdateChannelsCheckboxoff.Checked) 
        {
        	$AllowCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowCreateUpdateChannelsCheckboxon)

    $AllowCreateUpdateChannelsCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowCreateUpdateChannelsCheckboxoff.UseVisualStyleBackColor = $True
    $AllowCreateUpdateChannelsCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowCreateUpdateChannelsCheckboxoff.TabIndex = 1
    $AllowCreateUpdateChannelsCheckboxoff.Text = "False"
    $AllowCreateUpdateChannelsCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*5))) 
    $AllowCreateUpdateChannelsCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowCreateUpdateChannelsCheckboxoff.Name = "AllowCreateUpdateChannelsCheckboxoff"
    $AllowCreateUpdateChannelsCheckboxoff.Add_CheckStateChanged({
    if ($AllowCreateUpdateChannelsCheckboxoff.Checked) {$AllowCreateUpdateChannelsCheckboxon.checked=$false}
    if ($AllowCreateUpdateChannelsCheckboxon.Checked -or $AllowCreateUpdateChannelsCheckboxoff.Checked) 
        {
        	$AllowCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowCreateUpdateChannelsCheckboxoff)

    $AllowDeleteChannelsLabel = New-Object System.Windows.Forms.Label
    $AllowDeleteChannelsLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*6))) 
    $AllowDeleteChannelsLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowDeleteChannelsLabel.Text = "Allow Member Deletion of Channels"
    $mainForm.Controls.Add($AllowDeleteChannelsLabel) 

    $AllowDeleteChannelsCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowDeleteChannelsCheckboxon.UseVisualStyleBackColor = $True
    $AllowDeleteChannelsCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowDeleteChannelsCheckboxon.TabIndex = 1
    $AllowDeleteChannelsCheckboxon.Text = "True"
    $AllowDeleteChannelsCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*6))) 
    $AllowDeleteChannelsCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowDeleteChannelsCheckboxon.Name = "AllowDeleteChannelsCheckboxon"
    $AllowDeleteChannelsCheckboxon.Add_CheckStateChanged({
    if ($AllowDeleteChannelsCheckboxon.Checked) {$AllowDeleteChannelsCheckboxoff.checked=$false}
    if ($AllowDeleteChannelsCheckboxon.Checked -or $AllowDeleteChannelsCheckboxoff.Checked) 
        {
        	$AllowDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowDeleteChannelsCheckboxon)

    $AllowDeleteChannelsCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowDeleteChannelsCheckboxoff.UseVisualStyleBackColor = $True
    $AllowDeleteChannelsCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowDeleteChannelsCheckboxoff.TabIndex = 1
    $AllowDeleteChannelsCheckboxoff.Text = "False"
    $AllowDeleteChannelsCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*6))) 
    $AllowDeleteChannelsCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowDeleteChannelsCheckboxoff.Name = "AllowDeleteChannelsCheckboxoff"
    $AllowDeleteChannelsCheckboxoff.Add_CheckStateChanged({
    if ($AllowDeleteChannelsCheckboxoff.Checked) {$AllowDeleteChannelsCheckboxon.checked=$false}
    if ($AllowDeleteChannelsCheckboxon.Checked -or $AllowDeleteChannelsCheckboxoff.Checked) 
        {
        	$AllowDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowDeleteChannelsCheckboxoff)

    $AllowAddRemoveAppsLabel = New-Object System.Windows.Forms.Label
    $AllowAddRemoveAppsLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*7))) 
    $AllowAddRemoveAppsLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowAddRemoveAppsLabel.Text = "Allow Members to Add\Remove Apps"
    $mainForm.Controls.Add($AllowAddRemoveAppsLabel) 

    $AllowAddRemoveAppsCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowAddRemoveAppsCheckboxon.UseVisualStyleBackColor = $True
    $AllowAddRemoveAppsCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowAddRemoveAppsCheckboxon.TabIndex = 1
    $AllowAddRemoveAppsCheckboxon.Text = "True"
    $AllowAddRemoveAppsCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*7))) 
    $AllowAddRemoveAppsCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowAddRemoveAppsCheckboxon.Name = "AllowAddRemoveAppsCheckboxon"
    $AllowAddRemoveAppsCheckboxon.Add_CheckStateChanged({
    if ($AllowAddRemoveAppsCheckboxon.Checked) {$AllowAddRemoveAppsCheckboxoff.checked=$false}
    if ($AllowAddRemoveAppsCheckboxon.Checked -or $AllowAddRemoveAppsCheckboxoff.Checked) 
        {
        	$AllowAddRemoveAppsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowAddRemoveAppsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowAddRemoveAppsCheckboxon)

    $AllowAddRemoveAppsCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowAddRemoveAppsCheckboxoff.UseVisualStyleBackColor = $True
    $AllowAddRemoveAppsCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowAddRemoveAppsCheckboxoff.TabIndex = 1
    $AllowAddRemoveAppsCheckboxoff.Text = "False"
    $AllowAddRemoveAppsCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*7))) 
    $AllowAddRemoveAppsCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowAddRemoveAppsCheckboxoff.Name = "AllowAddRemoveAppsCheckboxoff"
    $AllowAddRemoveAppsCheckboxoff.Add_CheckStateChanged({
    if ($AllowAddRemoveAppsCheckboxoff.Checked) {$AllowAddRemoveAppsCheckboxon.checked=$false}
    if ($AllowAddRemoveAppsCheckboxon.Checked -or $AllowAddRemoveAppsCheckboxoff.Checked) 
        {
        	$AllowAddRemoveAppsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowAddRemoveAppsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowAddRemoveAppsCheckboxoff)

    $AllowCreateUpdateRemoveTabsLabel = New-Object System.Windows.Forms.Label
    $AllowCreateUpdateRemoveTabsLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*8))) 
    $AllowCreateUpdateRemoveTabsLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowCreateUpdateRemoveTabsLabel.Text = "Allow Members to Create\Update\Remove Tabs"
    $mainForm.Controls.Add($AllowCreateUpdateRemoveTabsLabel) 

    $AllowCreateUpdateRemoveTabsCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowCreateUpdateRemoveTabsCheckboxon.UseVisualStyleBackColor = $True
    $AllowCreateUpdateRemoveTabsCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowCreateUpdateRemoveTabsCheckboxon.TabIndex = 1
    $AllowCreateUpdateRemoveTabsCheckboxon.Text = "True"
    $AllowCreateUpdateRemoveTabsCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*8))) 
    $AllowCreateUpdateRemoveTabsCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowCreateUpdateRemoveTabsCheckboxon.Name = "AllowAddRemoveAppsCheckboxon"
    $AllowCreateUpdateRemoveTabsCheckboxon.Add_CheckStateChanged({
    if ($AllowCreateUpdateRemoveTabsCheckboxon.Checked) {$AllowCreateUpdateRemoveTabsCheckboxoff.checked=$false}
    if ($AllowCreateUpdateRemoveTabsCheckboxon.Checked -or $AllowCreateUpdateRemoveTabsCheckboxoff.Checked) 
        {
        	$AllowCreateUpdateRemoveTabsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowCreateUpdateRemoveTabsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowCreateUpdateRemoveTabsCheckboxon)

    $AllowCreateUpdateRemoveTabsCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowCreateUpdateRemoveTabsCheckboxoff.UseVisualStyleBackColor = $True
    $AllowCreateUpdateRemoveTabsCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowCreateUpdateRemoveTabsCheckboxoff.TabIndex = 1
    $AllowCreateUpdateRemoveTabsCheckboxoff.Text = "False"
    $AllowCreateUpdateRemoveTabsCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*8))) 
    $AllowCreateUpdateRemoveTabsCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowCreateUpdateRemoveTabsCheckboxoff.Name = "AllowAddRemoveAppsCheckboxoff"
    $AllowCreateUpdateRemoveTabsCheckboxoff.Add_CheckStateChanged({
    if ($AllowCreateUpdateRemoveTabsCheckboxoff.Checked) {$AllowCreateUpdateRemoveTabsCheckboxon.checked=$false}
    if ($AllowCreateUpdateRemoveTabsCheckboxon.Checked -or $AllowCreateUpdateRemoveTabsCheckboxoff.Checked) 
        {
        	$AllowCreateUpdateRemoveTabsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowCreateUpdateRemoveTabsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowCreateUpdateRemoveTabsCheckboxoff)

    $AllowCreateUpdateRemoveConnectorsLabel = New-Object System.Windows.Forms.Label
    $AllowCreateUpdateRemoveConnectorsLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*9))) 
    $AllowCreateUpdateRemoveConnectorsLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowCreateUpdateRemoveConnectorsLabel.Text = "Allow Members to Create\Update\Remove Connectors"
    $mainForm.Controls.Add($AllowCreateUpdateRemoveConnectorsLabel) 

    $AllowCreateUpdateRemoveConnectorsCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowCreateUpdateRemoveConnectorsCheckboxon.UseVisualStyleBackColor = $True
    $AllowCreateUpdateRemoveConnectorsCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowCreateUpdateRemoveConnectorsCheckboxon.TabIndex = 1
    $AllowCreateUpdateRemoveConnectorsCheckboxon.Text = "True"
    $AllowCreateUpdateRemoveConnectorsCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*9))) 
    $AllowCreateUpdateRemoveConnectorsCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowCreateUpdateRemoveConnectorsCheckboxon.Name = "AllowAddRemoveAppsCheckboxon"
    $AllowCreateUpdateRemoveConnectorsCheckboxon.Add_CheckStateChanged({
    if ($AllowCreateUpdateRemoveConnectorsCheckboxon.Checked) {$AllowCreateUpdateRemoveConnectorsCheckboxoff.checked=$false}
    if ($AllowCreateUpdateRemoveConnectorsCheckboxon.Checked -or $AllowCreateUpdateRemoveConnectorsCheckboxoff.Checked) 
        {
        	$AllowCreateUpdateRemoveConnectorsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowCreateUpdateRemoveConnectorsLabel.ForeColor = [System.Drawing.Color]::Black
        }  
    })
    $mainForm.Controls.Add($AllowCreateUpdateRemoveConnectorsCheckboxon)

    $AllowCreateUpdateRemoveConnectorsCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowCreateUpdateRemoveConnectorsCheckboxoff.UseVisualStyleBackColor = $True
    $AllowCreateUpdateRemoveConnectorsCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowCreateUpdateRemoveConnectorsCheckboxoff.TabIndex = 1
    $AllowCreateUpdateRemoveConnectorsCheckboxoff.Text = "False"
    $AllowCreateUpdateRemoveConnectorsCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*9))) 
    $AllowCreateUpdateRemoveConnectorsCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowCreateUpdateRemoveConnectorsCheckboxoff.Name = "AllowAddRemoveAppsCheckboxoff"
    $AllowCreateUpdateRemoveConnectorsCheckboxoff.Add_CheckStateChanged({
    if ($AllowCreateUpdateRemoveConnectorsCheckboxoff.Checked) {$AllowCreateUpdateRemoveConnectorsCheckboxon.checked=$false}
    if ($AllowCreateUpdateRemoveConnectorsCheckboxon.Checked -or $AllowCreateUpdateRemoveConnectorsCheckboxoff.Checked) 
        {
        	$AllowCreateUpdateRemoveConnectorsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowCreateUpdateRemoveConnectorsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowCreateUpdateRemoveConnectorsCheckboxoff)

    $AllowGuestCreateUpdateChannelsLabel = New-Object System.Windows.Forms.Label
    $AllowGuestCreateUpdateChannelsLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*10))) 
    $AllowGuestCreateUpdateChannelsLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowGuestCreateUpdateChannelsLabel.Text = "Allow Guests to Create\Update Channels"
    $mainForm.Controls.Add($AllowGuestCreateUpdateChannelsLabel) 

    $AllowGuestCreateUpdateChannelsCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowGuestCreateUpdateChannelsCheckboxon.UseVisualStyleBackColor = $True
    $AllowGuestCreateUpdateChannelsCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowGuestCreateUpdateChannelsCheckboxon.TabIndex = 1
    $AllowGuestCreateUpdateChannelsCheckboxon.Text = "True"
    $AllowGuestCreateUpdateChannelsCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*10))) 
    $AllowGuestCreateUpdateChannelsCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowGuestCreateUpdateChannelsCheckboxon.Name = "AllowAddRemoveAppsCheckboxon"
    $AllowGuestCreateUpdateChannelsCheckboxon.Add_CheckStateChanged({
    if ($AllowGuestCreateUpdateChannelsCheckboxon.Checked) {$AllowGuestCreateUpdateChannelsCheckboxoff.checked=$false}
    if ($AllowGuestCreateUpdateChannelsCheckboxon.Checked -or $AllowGuestCreateUpdateChannelsCheckboxoff.Checked) 
        {
        	$AllowGuestCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowGuestCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowGuestCreateUpdateChannelsCheckboxon)

    $AllowGuestCreateUpdateChannelsCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowGuestCreateUpdateChannelsCheckboxoff.UseVisualStyleBackColor = $True
    $AllowGuestCreateUpdateChannelsCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowGuestCreateUpdateChannelsCheckboxoff.TabIndex = 1
    $AllowGuestCreateUpdateChannelsCheckboxoff.Text = "False"
    $AllowGuestCreateUpdateChannelsCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*10))) 
    $AllowGuestCreateUpdateChannelsCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowGuestCreateUpdateChannelsCheckboxoff.Name = "AllowAddRemoveAppsCheckboxoff"
    $AllowGuestCreateUpdateChannelsCheckboxoff.Add_CheckStateChanged({
    if ($AllowGuestCreateUpdateChannelsCheckboxoff.Checked) {$AllowGuestCreateUpdateChannelsCheckboxon.checked=$false}
    if ($AllowGuestCreateUpdateChannelsCheckboxon.Checked -or $AllowGuestCreateUpdateChannelsCheckboxoff.Checked) 
        {
        	$AllowGuestCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowGuestCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowGuestCreateUpdateChannelsCheckboxoff)

    $AllowGuestDeleteChannelsLabel = New-Object System.Windows.Forms.Label
    $AllowGuestDeleteChannelsLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*11))) 
    $AllowGuestDeleteChannelsLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowGuestDeleteChannelsLabel.Text = "Allow Guests to Delete Channels"
    $mainForm.Controls.Add($AllowGuestDeleteChannelsLabel) 

    $AllowGuestDeleteChannelsCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowGuestDeleteChannelsCheckboxon.UseVisualStyleBackColor = $True
    $AllowGuestDeleteChannelsCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowGuestDeleteChannelsCheckboxon.TabIndex = 1
    $AllowGuestDeleteChannelsCheckboxon.Text = "True"
    $AllowGuestDeleteChannelsCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*11))) 
    $AllowGuestDeleteChannelsCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowGuestDeleteChannelsCheckboxon.Name = "AllowAddRemoveAppsCheckboxon"
    $AllowGuestDeleteChannelsCheckboxon.Add_CheckStateChanged({
    if ($AllowGuestDeleteChannelsCheckboxon.Checked) {$AllowGuestDeleteChannelsCheckboxoff.checked=$false}
    if ($AllowGuestDeleteChannelsCheckboxon.Checked -or $AllowGuestDeleteChannelsCheckboxoff.Checked) 
        {
        	$AllowGuestDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowGuestDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })

    $mainForm.Controls.Add($AllowGuestDeleteChannelsCheckboxon)

    $AllowGuestDeleteChannelsCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowGuestDeleteChannelsCheckboxoff.UseVisualStyleBackColor = $True
    $AllowGuestDeleteChannelsCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowGuestDeleteChannelsCheckboxoff.TabIndex = 1
    $AllowGuestDeleteChannelsCheckboxoff.Text = "False"
    $AllowGuestDeleteChannelsCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*11))) 
    $AllowGuestDeleteChannelsCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowGuestDeleteChannelsCheckboxoff.Name = "AllowAddRemoveAppsCheckboxoff"
    $AllowGuestDeleteChannelsCheckboxoff.Add_CheckStateChanged({
    if ($AllowGuestDeleteChannelsCheckboxoff.Checked) {$AllowGuestDeleteChannelsCheckboxon.checked=$false}
    if ($AllowGuestDeleteChannelsCheckboxon.Checked -or $AllowGuestDeleteChannelsCheckboxoff.Checked) 
        {
        	$AllowGuestDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowGuestDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowGuestDeleteChannelsCheckboxoff)


    $AllowAllowStickersMemesLabel = New-Object System.Windows.Forms.Label
    $AllowAllowStickersMemesLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*12))) 
    $AllowAllowStickersMemesLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowAllowStickersMemesLabel.Text = "Allow Stickers and Memes"
    $mainForm.Controls.Add($AllowAllowStickersMemesLabel) 

    $AllowAllowStickersMemesCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowAllowStickersMemesCheckboxon.UseVisualStyleBackColor = $True
    $AllowAllowStickersMemesCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowAllowStickersMemesCheckboxon.TabIndex = 1
    $AllowAllowStickersMemesCheckboxon.Text = "True"
    $AllowAllowStickersMemesCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*12))) 
    $AllowAllowStickersMemesCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowAllowStickersMemesCheckboxon.Name = "AllowAddRemoveAppsCheckboxon"
    $AllowAllowStickersMemesCheckboxon.Add_CheckStateChanged({
    if ($AllowAllowStickersMemesCheckboxon.Checked) {$AllowAllowStickersMemesCheckboxoff.checked=$false}
    if ($AllowAllowStickersMemesCheckboxon.Checked -or $AllowAllowStickersMemesCheckboxoff.Checked) 
        {
        	$AllowAllowStickersMemesLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowAllowStickersMemesLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowAllowStickersMemesCheckboxon)

    $AllowAllowStickersMemesCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowAllowStickersMemesCheckboxoff.UseVisualStyleBackColor = $True
    $AllowAllowStickersMemesCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowAllowStickersMemesCheckboxoff.TabIndex = 1
    $AllowAllowStickersMemesCheckboxoff.Text = "False"
    $AllowAllowStickersMemesCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*12))) 
    $AllowAllowStickersMemesCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowAllowStickersMemesCheckboxoff.Name = "AllowAddRemoveAppsCheckboxoff"
    $AllowAllowStickersMemesCheckboxoff.Add_CheckStateChanged({
    if ($AllowAllowStickersMemesCheckboxoff.Checked) {$AllowAllowStickersMemesCheckboxon.checked=$false}
    if ($AllowAllowStickersMemesCheckboxon.Checked -or $AllowAllowStickersMemesCheckboxoff.Checked) 
        {
        	$AllowAllowStickersMemesLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowAllowStickersMemesLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowAllowStickersMemesCheckboxoff)

    $AllowAllowCustomMemesLabel = New-Object System.Windows.Forms.Label
    $AllowAllowCustomMemesLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*13))) 
    $AllowAllowCustomMemesLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowAllowCustomMemesLabel.Text = "Allow Custom Memes"
    $mainForm.Controls.Add($AllowAllowCustomMemesLabel) 

    $AllowAllowCustomMemesCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowAllowCustomMemesCheckboxon.UseVisualStyleBackColor = $True
    $AllowAllowCustomMemesCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowAllowCustomMemesCheckboxon.TabIndex = 1
    $AllowAllowCustomMemesCheckboxon.Text = "True"
    $AllowAllowCustomMemesCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*13))) 
    $AllowAllowCustomMemesCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowAllowCustomMemesCheckboxon.Name = "AllowAddRemoveAppsCheckboxon"
    $AllowAllowCustomMemesCheckboxon.Add_CheckStateChanged({
    if ($AllowAllowCustomMemesCheckboxon.Checked) {$AllowAllowCustomMemesCheckboxoff.checked=$false}
    if ($AllowAllowCustomMemesCheckboxon.Checked -or $AllowAllowCustomMemesCheckboxoff.Checked) 
        {
        	$AllowAllowCustomMemesLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowAllowCustomMemesLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowAllowCustomMemesCheckboxon)

    $AllowAllowCustomMemesCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowAllowCustomMemesCheckboxoff.UseVisualStyleBackColor = $True
    $AllowAllowCustomMemesCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowAllowCustomMemesCheckboxoff.TabIndex = 1
    $AllowAllowCustomMemesCheckboxoff.Text = "False"
    $AllowAllowCustomMemesCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*13))) 
    $AllowAllowCustomMemesCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowAllowCustomMemesCheckboxoff.Name = "AllowAddRemoveAppsCheckboxoff"
    $AllowAllowCustomMemesCheckboxoff.Add_CheckStateChanged({
    if ($AllowAllowCustomMemesCheckboxoff.Checked) {$AllowAllowCustomMemesCheckboxon.checked=$false}
    if ($AllowAllowCustomMemesCheckboxon.Checked -or $AllowAllowCustomMemesCheckboxoff.Checked) 
        {
        	$AllowAllowCustomMemesLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowAllowCustomMemesLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowAllowCustomMemesCheckboxoff)


    $AllowGiphyLabel = New-Object System.Windows.Forms.Label
    $AllowGiphyLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*14))) 
    $AllowGiphyLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $AllowGiphyLabel.Text = "Allow Giphy"
    $mainForm.Controls.Add($AllowGiphyLabel) 

    $AllowGiphyCheckboxon = New-Object System.Windows.Forms.Checkbox
    $AllowGiphyCheckboxon.UseVisualStyleBackColor = $True
    $AllowGiphyCheckboxon.Size = New-Object System.Drawing.Size(60,20) 
    $AllowGiphyCheckboxon.TabIndex = 1
    $AllowGiphyCheckboxon.Text = "True"
    $AllowGiphyCheckboxon.Location = new-object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*14))) 
    $AllowGiphyCheckboxon.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowGiphyCheckboxon.Name = "AllowAddRemoveAppsCheckboxon"
    $AllowGiphyCheckboxon.Add_CheckStateChanged({
    if ($AllowGiphyCheckboxon.Checked) {$AllowGiphyCheckboxoff.checked=$false}
    if ($AllowGiphyCheckboxon.Checked -or $AllowGiphyCheckboxoff.Checked) 
        {
        	$AllowGiphyLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowGiphyLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowGiphyCheckboxon)

    $AllowGiphyCheckboxoff = New-Object System.Windows.Forms.Checkbox
    $AllowGiphyCheckboxoff.UseVisualStyleBackColor = $True
    $AllowGiphyCheckboxoff.Size = New-Object System.Drawing.Size(60,20) 
    $AllowGiphyCheckboxoff.TabIndex = 1
    $AllowGiphyCheckboxoff.Text = "False"
    $AllowGiphyCheckboxoff.Location = new-object System.Drawing.Size(($CheckboxTextWidth+400),($CheckboxStartHeight+($CheckboxHeightSpacing*14))) 
    $AllowGiphyCheckboxoff.DataBindings.DefaultDataSourceUpdateMode = 0
    $AllowGiphyCheckboxoff.Name = "AllowAddRemoveAppsCheckboxoff"
    $AllowGiphyCheckboxoff.Add_CheckStateChanged({
    if ($AllowGiphyCheckboxoff.Checked) {$AllowGiphyCheckboxon.checked=$false}
    if ($AllowGiphyCheckboxon.Checked -or $AllowGiphyCheckboxoff.Checked) 
        {
        	$AllowGiphyLabel.ForeColor = [System.Drawing.Color]::Green
        } 
    Else  
        {
        	$AllowGiphyLabel.ForeColor = [System.Drawing.Color]::Black
        } 
    })
    $mainForm.Controls.Add($AllowGiphyCheckboxoff)

    $GiphyContentRatingLabel = New-Object System.Windows.Forms.Label
    $GiphyContentRatingLabel.Location = New-Object System.Drawing.Size(320,($CheckboxStartHeight+($CheckboxHeightSpacing*15))) 
    $GiphyContentRatingLabel.Size = New-Object System.Drawing.Size($CheckboxTextWidth,20) 
    $GiphyContentRatingLabel.Text = "Giphy Content Rating"
    $mainForm.Controls.Add($GiphyContentRatingLabel) 

    $GiphyContentRatingDropdown = new-object System.Windows.Forms.ComboBox
    $GiphyContentRatingDropdown.Location = New-Object System.Drawing.Size(($CheckboxTextWidth+340),($CheckboxStartHeight+($CheckboxHeightSpacing*15))) 
    $GiphyContentRatingDropdown.Size = New-Object System.Drawing.Size(110,20) 
    $GiphyContentRatingDropdown.Anchor = 'Top, Left, Right'
    $GiphyContentRatingDropdown.add_SelectedIndexChanged({
    })
        [void]$GiphyContentRatingDropdown.Items.Add("")
        [void]$GiphyContentRatingDropdown.Items.Add("strict")
        [void]$GiphyContentRatingDropdown.Items.Add("moderate")

        $GiphyContentRatingDropdown.add_SelectedIndexChanged({
        if ($GiphyContentRatingDropdown.text -eq "") 
            {
                $GiphyContentRatingLabel.ForeColor = [System.Drawing.Color]::Black
            }
        Else
            {
                $GiphyContentRatingLabel.ForeColor = [System.Drawing.Color]::Green
            }
    })
    $mainForm.Controls.Add($GiphyContentRatingDropdown) 


    $ConnectTenantButton = New-Object System.Windows.Forms.Button
    $ConnectTenantButton.Location = New-Object System.Drawing.Size((10 + (($mainForm.width-50) /7 * 0) ),($mainForm.height - 90))
    $ConnectTenantButton.Size = New-Object System.Drawing.Size(115,25)
    $ConnectTenantButton.Text = "Connect to Tenant"
    $ConnectTenantButton.Add_Click({
        $TeamsListBox.Items.Clear()
        Connect-MicrosoftTeams
        $Teams=Get-Team
	    foreach ($team in $teams) 
	    {
		    [void] $TeamsListBox.Items.Add($team.displayname)
	    }
    })
    $ConnectTenantButton.Anchor = 'Bottom, Left'
    $mainForm.Controls.Add($ConnectTenantButton)

    $ApplyChangesToTeamsButton = New-Object System.Windows.Forms.Button
    $ApplyChangesToTeamsButton.Location = New-Object System.Drawing.Size((10 + (($mainForm.width-50) /7 * 1) ),($mainForm.height - 90))
    $ApplyChangesToTeamsButton.Size = New-Object System.Drawing.Size(115,25)
    $ApplyChangesToTeamsButton.Text = "Apply Changes"
    $ApplyChangesToTeamsButton.Add_Click({
        $ApplyChangesToTeamsButton.enabled=$False
        foreach ($TeamName in $TeamsListBox.SelectedItems) {
            $team=get-team |where {$_.displayname -eq $TeamName}
            if ($AllowUserEditLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamMessagingSettings -groupid $team.groupid -AllowUserEditMessages $AllowUserEditCheckboxon.checked}
            if ($AllowUserDeleteLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamMessagingSettings -groupid $team.groupid -AllowUserDeleteMessages $AllowUserDeleteCheckboxon.checked}
            if ($AllowOwnerDeleteLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamMessagingSettings -groupid $team.groupid -AllowOwnerDeleteMessages $AllowOwnerDeleteCheckboxon.checked}
            if ($AllowTeamMentionsLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamMessagingSettings -groupid $team.groupid -AllowTeamMentions $AllowTeamMentionsCheckboxon.checked}
            if ($AllowChannelMentionsLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamMessagingSettings -groupid $team.groupid -AllowChannelMentions $AllowChannelMentionsCheckboxon.checked}
            if ($AllowCreateUpdateChannelsLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamMemberSettings -groupid $Team.groupid -AllowCreateUpdateChannels $AllowCreateUpdateChannelsCheckboxon.checked}
            if ($AllowDeleteChannelsLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamMemberSettings -groupid $Team.groupid -AllowDeleteChannels $AllowDeleteChannelsCheckboxon.checked}
            if ($AllowAddRemoveAppsLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamMemberSettings -groupid $Team.groupid -AllowAddRemoveApps $AllowAddRemoveAppsCheckboxon.checked}
            if ($AllowCreateUpdateRemoveTabsLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamMemberSettings -groupid $Team.groupid -AllowCreateUpdateRemoveTabs $AllowCreateUpdateRemoveTabsCheckboxon.checked}
            if ($AllowCreateUpdateRemoveConnectorsLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamMemberSettings -groupid $Team.groupid -AllowCreateUpdateRemoveConnectors $AllowCreateUpdateRemoveConnectorsCheckboxon.checked}
            if ($AllowGuestCreateUpdateChannelsLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamGuestSettings -groupid $Team.groupid -AllowCreateUpdateChannels $AllowGuestCreateUpdateChannelsCheckboxon.checked}
            if ($AllowGuestDeleteChannelsLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamGuestSettings -groupid $Team.groupid -AllowDeleteChannels $AllowGuestDeleteChannelsCheckboxon.checked}
            if ($AllowAllowStickersMemesLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamFunSettings -groupid $Team.groupid -AllowStickersAndMemes $AllowAllowStickersMemesCheckboxon.checked}
            if ($AllowAllowCustomMemesLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamFunSettings -groupid $Team.groupid -AllowCustomMemes $AllowAllowCustomMemesCheckboxon.checked}
            if ($AllowGiphyLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamFunSettings -groupid $Team.groupid -AllowGiphy $AllowGiphyCheckboxon.checked}
            if ($GiphyContentRatingLabel.ForeColor -eq [System.Drawing.Color]::Green) {Set-TeamFunSettings -groupid $Team.groupid -GiphyContentRating $GiphyContentRatingDropdown.Selecteditem}
        }
        $AllowUserEditLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowUserDeleteLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowOWnerDeleteLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowTeamMentionsLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowChannelMentionsLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowAddRemoveAppsLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowCreateUpdateRemoveTabsLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowCreateUpdateRemoveConnectorsLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowGuestCreateUpdateChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowGuestDeleteChannelsLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowAllowStickersMemesLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowAllowCustomMemesLabel.ForeColor = [System.Drawing.Color]::Black
        $AllowGiphyLabel.ForeColor = [System.Drawing.Color]::Black
        $GiphyContentRatingLabel.ForeColor = [System.Drawing.Color]::Black
        $ApplyChangesToTeamsButton.enabled=$True
    })
    $ApplyChangesToTeamsButton.Anchor = 'Bottom, Left'
    $mainForm.Controls.Add($ApplyChangesToTeamsButton)

    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Size((10 + (($mainForm.width-50) /7 * 6) ),($mainForm.height - 90))
    $CancelButton.Size = New-Object System.Drawing.Size(115,25)
    $CancelButton.Text = "Quit"
    $CancelButton.Add_Click({$mainForm.Close()})
    $CancelButton.Anchor = 'Bottom, Left'
    $mainForm.Controls.Add($CancelButton)

    #TeamsAdmin LinkLabel
    $TeamsAdminLinkLabel = New-Object System.Windows.Forms.LinkLabel
    $TeamsAdminLinkLabel.Location = New-Object System.Drawing.Size(10,($mainForm.height - 60)) 
    $TeamsAdminLinkLabel.Size = New-Object System.Drawing.Size(200,20)
    $TeamsAdminLinkLabel.text = "http://www.TeamsAdmin.com"
    $TeamsAdminLinkLabel.add_Click({Start-Process $TeamsAdminLinkLabel.text})
    $TeamsAdminLinkLabel.Anchor = 'Bottom, Left'
    $mainForm.Controls.Add($TeamsAdminLinkLabel)

    [void] $mainForm.ShowDialog()

}

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[void] [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

CheckForInstalledModules
MainForm
