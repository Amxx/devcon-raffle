import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"
import { config } from '../scripts/deploymentConfig'
import { ethers } from "ethers"

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
	const {
		deployments: { deploy },
	} = hre
	const [deployer] = await hre.ethers.getSigners()

	let factory = await deploy("AuctionRaffle", {
		from: deployer.address,
		args: [
      config.initialOwner,
      config.biddingStartTime,
      config.biddingEndTime,
      config.claimingEndTime,
      config.auctionWinnersCount,
      config.raffleWinnersCount,
      config.reservePrice,
      config.minBidIncrement,
      ethers.utils.defaultAbiCoder.encode(['uint256'], ['0x0'])
    ],
		log: true,
	})
}

export default func
func.tags = ["AuctionRaffle"]
