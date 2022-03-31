import {ethers} from "ethers";
import addressesConst from "@/consts/addresses.const";
import ABI from "@/contracts/betting";

export async function getBettingService() {
    let bettingAddress = addressesConst.bettingAddress
    let provider = ethers.getDefaultProvider("http://localhost:7545")
    let blockNumber = await provider.getBlockNumber()
    const signer = provider.getSigner()
    // eslint-disable-next-line no-unused-vars
    let bettingContract = new ethers.Contract(bettingAddress, ABI, signer)
    //console.log(await bettingContract.name())
    console.log(blockNumber)
    //let signature = await signer.signMessage("AlfaRomeo");
    let amount = ethers.utils.parseEther("0.1")
    let currentValue = await bettingContract.bet("AlfaRomeo", {value: amount});
    console.log(currentValue)
    //console.log(currentValue)
}
