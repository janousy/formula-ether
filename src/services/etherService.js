import {ethers} from "ethers";
import addressesConst from "@/consts/addresses.const";
import ABI from "@/contracts/bettingAbi";

export async function sendBet(ethAmount, signer) {
    let bettingAddress = addressesConst.bettingAddress;
    let bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('calling contract: ', bettingContract);
    try {
        let response = await bettingContract.bet("AlfaRomeo", {value: ethAmount});
        console.log(response)
    } catch (ex) {
        console.warn(ex)
    }
}

export async function getWinners(signer) {
    let bettingAddress = addressesConst.bettingAddress;
    let bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('calling contract: ', bettingContract);
    try {
        let winners = await bettingContract.get_winner();
        console.log(winners);
        return winners
    } catch (ex) {
        console.warn(ex)
    }

}

export async function getTotalAmount(signer) {
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('Calling contract for totalBetAmount', bettingContract);
    try {
        const totalAmount = await bettingContract.getAmounts();
        console.log(totalAmount);
        return totalAmount
    } catch (err) {
        console.warn(err);
    }
    return 0;
}

export default sendBet()
