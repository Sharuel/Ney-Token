// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract JBO {
    string public name;
    address private owner;
    uint256 public million;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value);
    constructor(uint256 _initialSupply) {
        name = "JBO";
        symbol = "JBO";
        decimals = 8;
        owner = msg.sender;
        million = 1000000 * 10 ** decimals;
        totalSupply = _initialSupply * 10 ** uint256(8);
        balanceOf[msg.sender] = totalSupply;
    }
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(_value <= allowance[_from][msg.sender], "Allowance exceeded");
        
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
    function mint(address _to, uint256 _value) public returns (bool success) {
    require(msg.sender == owner, "Vi ne vladelec moli koinow ts");
    require(_value * 10 ** decimals <= million, "1000-7?");
    require(_to != address(0), "Invalid address");
    million -= _value * (10 ** uint256(decimals));
    totalSupply += _value * (10 ** uint256(decimals));
    balanceOf[_to] += _value * (10 ** uint256(decimals));
    emit Mint(_to, _value * (10 ** uint256(decimals)));
    return true;
}
}
