import {ethers} from "ethers";
import addressesConst from "@/consts/addresses.const";
import ABI from "@/contracts/bettingAbi";

export async function sendBet(ethAmount, team, signer) {
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('calling contract to place bet');
    try {
        let response = await bettingContract.bet(team.key, {value: ethAmount});
        console.log(response)
    } catch (ex) {
        console.warn(ex)
    }
}

export async function distributePrices(signer) {
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('calling contract to start race');
    try {
        let response = await bettingContract.distributePrizes();
        console.log(response)
    } catch (ex) {
        console.warn(ex)
    }
}

export async function getAllPlayers(signer) {
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('calling contract for all players');
    try {
        return await bettingContract.getPlayers();
    } catch (ex) {
        console.warn(ex)
    }
}

export async function getWinningPlayers(signer) {
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('calling contract to get winning players');
    try {
        return await bettingContract.getWinnerPlayers()
    } catch (ex) {
        console.warn(ex)
    }
}

export async function getWinningTeam(signer) {
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('calling contract to get winning Team');
    try {
        return await bettingContract.get_winner()
    } catch (ex) {
        console.warn(ex)
    }
}

export async function getTotalAmount(signer) {
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('Calling contract for totalBetAmount');
    try {
        return await bettingContract.getAmounts()
    } catch (err) {
        console.warn(err);
    }
    return 0;
}
