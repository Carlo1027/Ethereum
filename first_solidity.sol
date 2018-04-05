pragma solidity ^0.4.16;

contract TokenERC20 {
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;
    mapping (address => uint256) public balanceOf;
    
    event Transfer (address from,address to, uint256 value);
    
    function TokenERC20(uint256 initialSupply, string tokenName, string tokenSymbol) public {
        totalSupply = initialSupply * 10 ** uint256(decimals);
        name = tokenName;
        symbol = tokenSymbol;
        balanceOf[msg.sender] = totalSupply;
    }
    
    function _transfer (address _from, address _to, uint _value) internal {
        require(balanceOf[_from] >= _value); // valido datos de entrada
        require(balanceOf[_to] + _value > balanceOf[_to]);
        uint previousBalances = balanceOf[_from] + balanceOf[_to]; // 
        balanceOf[_from] -= _value; //quien envia
        balanceOf[_to] += _value; //quien recibe
        Transfer(_from, _to, _value);
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances); // validar estados (si todo quedó como antes)
    }
    
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
        
    }
}

interface TokenERC20Interface {
    function transfer(address _to, uint256 _value) public;
}

contract BasicContract {
    function transferToken(){
        TokenERC20Interface token = TokenERC20Interface(0x1459b55e171400dfbf69f834fa6e80232b014ce8); // direccion del contrato
        token.transfer(0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db,1); // direccion de otra cuenta tercera
    }
}