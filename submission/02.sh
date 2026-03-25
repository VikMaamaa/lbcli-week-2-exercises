# Create a new Bitcoin address, for receiving change.
#!/bin/bash
bitcoin-cli -regtest -rpcwallet=btrustwallet getrawchangeaddress