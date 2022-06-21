// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract TwoDeepToken {
    string public name = "Two Deep Token";
    string public symbol = "TDT";
    string public standard = "2Deep Token v1.0";
    uint256 public totalSupply;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    // Returns the account balance of another account with address _owner.
    mapping(address => uint256) public balanceOf;
    // the amount which _spender is still allowed to withdraw from _owner.
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(uint256 _initialSupply) {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }

    //transfer
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value); //sender balance should be greater than _value

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    /*
        APROVE 
        Allows _spender to withdraw from your account multiple times, up to the _value amount.
        If this function is called again it overwrites the current allowance with _value.
    */
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /*
        TRANSFER FROM
        Transfers _value amount of tokens from address _from to address _to, 
        and MUST fire the Transfer event.
         allow a contract to transfer tokens on your behalf and/or to charge 
         fees in sub-currencies. The function SHOULD throw unless the _from account
          has deliberately authorized the sender of the message via some mechanism.
    */

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
}
