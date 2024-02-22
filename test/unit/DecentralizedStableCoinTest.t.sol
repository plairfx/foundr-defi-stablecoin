// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract DecentralizedStablecoinTest is StdCheats, Test {
    DecentralizedStableCoin dsc;

    function setUp() public {
        dsc = new DecentralizedStableCoin();
    }

    function testMustBeMoreThanZero() public {
        vm.prank(dsc.owner());
        vm.expectRevert();
        dsc.mint(address(this), 0);
    }

    function testMustBurnMoreZero() public {
        vm.prank(dsc.owner());
        vm.expectRevert();
        dsc.burn(0);
    }

    function testCantBurnMoreThanYouHave() public {
        vm.prank(dsc.owner());
        dsc.mint(address(this), 1);
        vm.expectRevert();
        dsc.burn(2);
    }

    function testCantMintToZeroAddress() public {
        vm.prank(dsc.owner());
        if (dsc.owner() == address(0)) {
            vm.expectRevert();
            dsc.mint(address(0), 1);
        }
    }
}
