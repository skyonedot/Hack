// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

interface IAir {
    function mintNFT(uint256 num) payable external;
    function safeTransferFrom(address from,address to,uint256 tokenId) external;
}


//部署这个类
contract batch_claim_token is IERC721Receiver  {


    constructor(){}

    //调用这个函数，参数就是领取数量
    function attack(uint256 amount,address token) payable public{
        for (uint i = 0; i <amount;i++)
        {
            IAir(token).mintNFT{value: 0.01 ether}(1);
        }
    }

    function onERC721Received(address, address, uint256, bytes memory) public virtual override  returns (bytes4) {
        return this.onERC721Received.selector;
    }

    function withdraw(uint256 start,uint256 end) public {
        for(uint i=start;i<end;i++){
            IAir(0x58491Ff7dF1D98ee02a876314FC292b9b54C206d).safeTransferFrom(address(this),0x8a09FB23E1c8d0FF9c9Fef0BcFc9b9e07B1f0667,i);
        }
    }

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}
}