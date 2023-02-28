# HelloID-Task-SA-Target-ActiveDirectory-AccountUpdateExpireDate
################################################################
# Form mapping
$formObject = @{
    UserPrincipalName = $form.UserPrincipalName
    ExpirationDate    = $form.ExpirationDate
}

try {
    Write-Information "Executing ActiveDirectory action: [SetExpirationDate] for: [$($formObject.UserPrincipalName)]"
    Import-Module ActiveDirectory -ErrorAction Stop
    $user = Get-ADUser -Filter "userPrincipalName -eq '$($formObject.UserPrincipalName)'"
    if ($user) {
        $expirationDate = $($formObject.ExpirationDate)
        $null = Set-ADAccountExpiration -Identity $user -DateTime $expirationDate
        $auditLog = @{
            Action            = 'UpdateAccount'
            System            = 'ActiveDirectory'
            TargetDisplayName = $($formObject.UserPrincipalName)
            TargetIdentifier  = ($user).SID.value
            Message           = "ActiveDirectory action: [SetExpirationDate] for: [$($formObject.UserPrincipalName)] executed successfully"
            IsError           = $false
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "ActiveDirectory action: [SetExpirationDate] for: [$($formObject.UserPrincipalName)] executed successfully"
    } elseif (-not($user)) {
        $auditLog = @{
            Action            = 'UpdateAccount'
            System            = 'ActiveDirectory'
            TargetDisplayName = $($formObject.UserPrincipalName)
            TargetIdentifier  = ''
            Message           = "An ActiveDirectory account for: [$($formObject.UserPrincipalName)] does not exist"
            IsError           = $true
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "An ActiveDirectory account for: [$($formObject.UserPrincipalName)] does not exist"
    }
} catch {
    $ex = $_
    $auditLog = @{
        Action            = 'UpdateAccount'
        System            = 'ActiveDirectory'
        TargetDisplayName = $($formObject.UserPrincipalName)
        TargetIdentifier  = ($user).SID.value
        Message           = "Could not execute ActiveDirectory action: [SetExpirationDate] for: [$($formObject.UserPrincipalName)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "Could not execute ActiveDirectory action: [SetExpirationDate] for: [$($formObject.UserPrincipalName)], error: $($ex.Exception.Message)"
}
################################################################
