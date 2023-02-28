
# HelloID-Task-SA-Target-ActiveDirectory-AccountUpdateExpireDate

## Prerequisites

- [ ] The HelloID SA on-premises agent installed

- [ ] The ActiveDirectory module is installed on the server where the HelloID SA on-premises agent is running.

## Description

This code snippet executes the following tasks:

1. Define a hash table `$formObject` that holds the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
    "UserPrincipalName": "",
    "ExpirationDate": "01/01/2023"
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hashtable is appropriately adjusted to match your form fields.

2. Imports the ActiveDirectory module.

3. Retrieve the user account object using the `Get-ADUser` cmdlet.

4. Update the account using the `$user` object retrieved from step 3 and update the `ExpirationDate`.

> :bulb: Its worth noting that the `ExpirationDate` must be a valid `DateTime` object.
