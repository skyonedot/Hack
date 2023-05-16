// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import '../src/Tata.sol';
import {console} from "forge-std/console.sol";

contract TataTest is Test {
    CoinToken public tata;
    address public charityAddress = address(0x123);
    address public alice = address(0x456);
    address public bob = address(0x789);

    function setUp() public {
        //6% txFee
        //7% burn Fee
        //1% charity Fee
        tata = new CoinToken("Tata", "TT", 18, 1000000, 6, 7, 1, charityAddress,  address(this));
    }

    // function testCheckBalance() public {
    //     assert(tata.balanceOf(address(this)) == 1000000*1 ether);
    //     console.log("After Init _rTotal",tata._rTotal());
    //     console.log("After Init _tTotal",tata._tTotal());
    //     // console.log(~uint256(0));
    //     // console.log(tata.balanceOf(address(this))/1 ether);
    // }

    // function testTransfer() public {
    //     tata.transfer(alice, 1000*1 ether);
    //     console.log(tata.balanceOf(alice)/1 ether);
    //     console.log(tata.balanceOf(address(this))/1 ether);
    //     // assert(tata.balanceOf(alice) == 1000*1 ether);
    //     // assert(tata.balanceOf(address(this)) == 1000000*1 ether - 1000*1 ether);
    // }

    function testBurn() public {
        //这样的确大, 但是也仅仅大的有限.
        //  163423 --> 54334
        //  823451 --> 273779
        tata.transfer(alice, tata.balanceOf(address(this))*3/16);
        console.log(tata.balanceOf(alice)/1 ether);
        console.log(tata.balanceOf(address(this))/1 ether);
        console.log("RTotal", tata._rTotal());
        console.log("TTotal", tata._tTotal());
        tata.burn(tata.balanceOf(address(this))*4/5);
        // console.log("RTotal", tata._rTotal());
        // console.log("TTotal", tata._tTotal());
        console.log(tata.balanceOf(alice)/1 ether);
        console.log(tata.balanceOf(address(this))/1 ether);
        // assert(tata.balanceOf(alice) == 1000*1 ether);
        // assert(tata.balanceOf(address(this)) == 1000000*1 ether - 1000*1 ether);
    }

}