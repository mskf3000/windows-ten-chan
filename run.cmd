@ECHO off
goto check_permission
goto ask_key
goto uninstall_product
goto activate_product
goto verify_product
goto verify_kms

:check_permission
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo [/] Success: Administrative permissions confirmed.
    ) else (
        echo [X] Error 1: Please grant administrative permissions by simple just right click then "Run as administrator"
        pause
        exit
    )

:ask_key
    set /p key="Please enter your key that match with your Windows version: "

:ask_server
    set /p server="Please enter your KMS server address for KMS activation: "

:uninstall_product
    cscript slmgr.vbs /upk
    if %errorLevel% == 0 (
        echo [/] Success: Uninstalled product key.
    ) else (
        echo [X] Error 2: Cannot uninstall a current product.
        pause
        exit
    )

:activate_product
    cscript slmgr.vbs /ipk %key%
    if %errorLevel% == 0 (
        echo [/] Success: Activated key.
    ) else (
        echo [X] Error 3: Cannot activate this key. Please check your key is match with current Windows version.
        pause
        exit
    )

:verify_product
    cscript slmgr.vbs /dlv
    if %errorLevel% == 0 (
        echo [/] Success: Product verified.
    ) else (
        echo [X] Error 4: Cannot verify this product.
        pause
        exit
    )

:server_product
    cscript slmgr.vbs /skms %server%
    if %errorLevel% == 0 (
        echo [/] Success: KMS server set.
    ) else (
        echo [X] Error 5: Cannot set KMS server.
        pause
        exit
    )

:verify_kms
    cscript slmgr.vbs /ato
    if %errorLevel% == 0 (
        echo [/] Success: KMS is verified.
    ) else (
        echo [X] Error 5: Cannot verify with this key and KMS server. Please check your key and your domain KMS server.
        pause
        exit
    )

echo [/] Welcome aboard, lad! Joy with our pirate ship.
pause