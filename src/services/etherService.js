import {ethers} from "ethers";
import addressesConst from "@/consts/addresses.const";
import ABI from "@/contracts/bettingAbi";

export async function sendBet(ethAmount, signer) {
    let bettingAddress = addressesConst.bettingAddress
    let bettingContract = new ethers.Contract(bettingAddress, ABI, signer)
    console.log('calling contract: ', bettingContract)
    try {
        let response = await bettingContract.bet("AlfaRomeo", {value: ethAmount});
        console.log(response)
    } catch (ex) {
        console.warn(ex)
    }
}

export async function getWinners(signer) {
    let bettingAddress = addressesConst.bettingAddress
    let bettingContract = new ethers.Contract(bettingAddress, ABI, signer)
    console.log('calling contract: ', bettingContract)
    try {
        let winners = await bettingContract.get_winner();
        console.log(winners)
        return winners
    } catch (ex) {
        console.warn(ex)
    }

}

export default sendBet()
