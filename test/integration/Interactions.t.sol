// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployRaffle} from "../../script/DeployRaffle.s.sol";
import {Raffle} from "../../src/Raffle.sol";
import {Test, console} from "forge-std/Test.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {Vm} from "forge-std/Vm.sol";
import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";

contract Interactions is Test {
    DeployRaffle deployer;
    HelperConfig helperConfig;

    function setUp() public {
        vm.startBroadcast();
        deployer = new DeployRaffle();
        vm.stopBroadcast();
    }

    function testDeploySetup() public {
        Raffle raffle;
        (raffle, helperConfig) = deployer.run();
        (
            uint256 entranceFee,
            uint256 interval,
            address vrfCoordinator,
            bytes32 keyHash,
            ,
            uint32 callbackGasLimit,
            address link,
            uint256 deployerKey
        ) = helperConfig.activeNetworkConfig();

        assert(entranceFee > 0);
        assert(interval > 0);
        assert(vrfCoordinator != address(0));
        assert(keyHash != 0);
        assert(callbackGasLimit > 0);
        assert(link != address(0));
        assert(deployerKey != 0);

        assert(address(raffle) != address(0));
    }
}
