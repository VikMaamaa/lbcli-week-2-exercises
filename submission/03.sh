# Create a SegWit address.
# Add funds to the address.
# Return only the Address
#!/bin/bash
ADDRESS=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "funding" "bech32")
bitcoin-cli -regtest generatetoaddress 101 "$ADDRESS" > /dev/null
echo "$ADDRESS"