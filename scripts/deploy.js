const { ethers } = require("hardhat");
const fs = require("fs");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const MyToken = await ethers.getContractFactory("MyToken");
  const token = await MyToken.deploy();

  console.log("Token address:", token.address);
var i=0;
  const rawdata = fs.readFileSync("Assets/Assets.json");
  const assets = JSON.parse(rawdata.toString());

  for (const characterName in assets) {
    i=i+1;
    const asset = assets[characterName];
    await token.SetDetails(characterName, i,1, asset.baseURI, asset.levelmaxURI);
    console.log(`Details set for ${characterName}`);
    await token.safeMint(deployer.address,i,i,{value: ethers.utils.parseEther("0.001")});
    console.log(`Minted ${characterName} to ${deployer.address}`);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });


  // npx hardhat run scripts/deploy.js --network shardeum
  // deployment code