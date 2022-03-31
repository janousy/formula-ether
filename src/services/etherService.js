import {ethers} from "ethers";
import addressesConst from "@/consts/addresses.const";
import ABI from "@/contracts/bettingAbi";

export async function sendBet(amount, signer) {
    let bettingAddress = addressesConst.bettingAddress
    let bettingContract = new ethers.Contract(bettingAddress, ABI, signer)
    //let signature = await signer.signMessage("AlfaRomeo");
    console.log("Amount to bet: ", amount)
    let valueAmount = ethers.utils.parseEther(amount.toString())
    try {
        let response = await bettingContract.bet("AlfaRomeo", {value: valueAmount});
        console.log(response)
    } catch (ex) {
        console.warn(ex)
    }
}
export default sendBet()
