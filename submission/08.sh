# Create a raw transaction with a transaction fee of 20,000 satoshis 
# The transaction fee should be 20,000 satoshis, then the rest of the amount should be sent to the address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP
# Use the UTXOs from the transaction below
# raw_tx="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"
#!/bin/bash
raw_tx="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"
RECIPIENT="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"
TRXN_FEE_SATS=20000
RBF_SEQ=4294967293
DECODED=$(bitcoin-cli -regtest decoderawtransaction "$raw_tx")
TXID=$(echo "$DECODED" | jq -r '.txid')
VAL0=$(echo "$DECODED" | jq -r '.vout[0].value')
VAL1=$(echo "$DECODED" | jq -r '.vout[1].value')
TOTAL_INPUT=$(echo "$VAL0 + $VAL1" | bc)
AMOUNT=$(echo "$TOTAL_INPUT - 0.00020000" | bc)
FORMATTED_AMOUNT=$(printf "%.8f" $AMOUNT)
bitcoin-cli -regtest createrawtransaction \
  "[{\"txid\":\"$TXID\",\"vout\":0,\"sequence\":$RBF_SEQ},{\"txid\":\"$TXID\",\"vout\":1,\"sequence\":$RBF_SEQ}]" \
  "{\"$RECIPIENT\":$FORMATTED_AMOUNT}"