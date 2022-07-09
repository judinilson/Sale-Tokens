// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./TwoDeepToken.sol";

contract TwoDeepTokenSale {
    address payable admin;

    TwoDeepToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address _buyer, uint256 _amount);

    constructor(TwoDeepToken _tokenContract, uint256 _tokenPrice) {
        //the person tha deploy the contract
        admin = payable(msg.sender);
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function multiply(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == multiply(_numberOfTokens, tokenPrice)); //checking if buyer is buying less than number of tokens
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens); //checking if buyer is buying more tokens than number of tokens
        require(tokenContract.transfer(msg.sender, _numberOfTokens)); // require that the transfer is successful

        tokensSold += _numberOfTokens; //keep track of the number of tokens sold

        emit Sell(msg.sender, _numberOfTokens); // emit the sell events
    }

    function endSale() public {
        require(msg.sender == admin); // checking if the person that is calling this function is admin
        require( //remaing tokens back to admin
            tokenContract.transfer(
                admin,
                tokenContract.balanceOf(address(this))
            )
        );
        // // UPDATE: Let's not destroy the contract here
        // // Just transfer the balance to the admin

        admin.transfer(address(this).balance);
    }
}
