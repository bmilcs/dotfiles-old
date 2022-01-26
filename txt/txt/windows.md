# Backup Settings [SMB]

Common Error: 
    The validation information class requested was invalid. (0x80070544).
    (0x80070544: The specified network location cannot be used.)

Fix:
  
  Path: \\freenas\share\
  User: **FREENAS\bmilcs
  *Pass: ***********-----------
  
# RDP as Microsoft Account Fix

Invalid password fix:
    on the pc you're trying to connect to:

  runas /u:MicrosoftAccount\bmilcs@yahoo.com cmd.exe

    
