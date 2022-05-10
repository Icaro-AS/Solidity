//Versão do Ethereum
pragma solidity ^0.8.13;
//Definimos um contrato
contract ZombieFactory {
   
   //Um evento dispara para o frontend alguma alteração na blockchain
   event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    //Em solidity existe nível de acesso private/public
    function _createZombie(string _name, uint _dna) private {
        //A função push sempre retorna
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        NewZombie(id, _name, _dna);
    } 

    //O modificador view indica que essa função não altera estado ou escreve algo
    //Uma função que nem mesmo lê um estado da aplicação pode receber a palavra chave pure
    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createTandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
