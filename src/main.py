from pysat.solvers import Glucose3
from bitarray import bitarray
from web3 import Web3

class BoolSAT():
    def __init__(self, clauses):
        self.clauses = clauses
        self.n = max([abs(x) for clause in clauses for x in clause])
        self.nbr_of_clauses = len(clauses)

    def serialize(self):
        print(self.clauses)
        res = bytearray()
        for clause in self.clauses:
            for token in clause:
                token += 128
                res += token.to_bytes(2, 'big')
            res += int(128).to_bytes(2, 'big')
        print(len(res))
        return res

    @staticmethod
    def deserialize(arr):
        pass

class TSAT:
    def __init__(self, clauses):
        self.clauses = clauses
        self.n = max([abs(x) for clause in clauses for x in clause])
        self.nbr_of_clauses = len(clauses)

    def serialize(self):
        bit_array = bitarray(100)
        bit_array[0:20] = 1
        print(bit_array)
        return 

    @staticmethod
    def deserialize():
        pass

# Converters: Problem formulation -> BoolSAT or TSAT
class Converters():
    def __init__():
        pass

class Converter():
    def __init__():
        pass


def main():
    clauses  = [[-1, 2],
                [-1, -3]]

    problem = BoolSAT(clauses)
    
    g = Glucose3()
    for clause in problem.clauses:
        g.add_clause(clause)

    print(g.solve())
    print(g.get_model())
    print(problem.serialize())
    
main()

# How to use MM? Allow(...) Sell(...)
# Buy - straightforward. Sell - Approve(...), Sell(...)


# Connect to Alchemy!
# w3 = Web3(Web3.HTTPProvider('https://yourproviderurl'))
# w3 = Web3(EthereumTesterProvider())
# w3.eth.get_block('latest')
# print(w3.isConnected())

    
#get the nonce.  Prevents one from sending the transaction twice
#nonce = web3.eth.getTransactionCount(account_1)

#build a transaction in a dictionary
#tx = {
#    'nonce': nonce,
#    'to': account_2,
#    'value': web3.toWei(1, 'ether'),
#    'gas': 2000000,
#    'gasPrice': web3.toWei('50', 'gwei')
#}

#sign the transaction
#signed_tx = web3.eth.account.sign_transaction(tx, private_key1)

#send transaction
#tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)

#get transaction hash
#print(web3.toHex(tx_hash))