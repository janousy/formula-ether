import {ethers} from "ethers";
import addressesConst from "@/consts/addresses.const";
import ABI from "@/contracts/bettingAbi";

export async function sendBet(ethAmount, team, signer) {
    if (!signer) {
        console.warn('No signer found');
    }
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('Calling contract to place bet');
    try {
        let response = await bettingContract.bet(team.key, {value: ethAmount});
        console.log(response)
        return 1;
    } catch (ex) {
        console.warn(ex)
        return -1;
    }
}

export async function distributePrices(signer) {
    if (!signer) {
        console.warn('No signer found');
    }
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('Calling contract to start race');
    try {
        let response = await bettingContract.distributePrizes();
        console.log(response)
    } catch (ex) {
        console.warn(ex)
    }
}

export async function getAllPlayers(signer) {
    if (!signer) {
        console.warn('No signer found');
    }
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('Calling contract for all players');
    try {
        return await bettingContract.getPlayers();
    } catch (ex) {
        console.warn(ex)
    }
}

export async function getWinningPlayers(signer) {
    if (!signer) {
        console.warn('No signer found');
    }
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('Calling contract to get winning players');
    try {
        return await bettingContract.getWinnerPlayers()
    } catch (ex) {
        console.warn(ex)
    }
}

export async function getWinningTeam(signer) {
    if (!signer) {
        console.warn('No signer found');
    }
    const bettingAddress = addressesConst.bettingAddress;
    const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('Calling contract to get winning Team');
    try {
        return await bettingContract.get_winner()
    } catch (ex) {
        console.warn(ex)
    }
}

export async function getTotalAmount(signer) {
    if (!signer) {
        console.warn('No signer found');
    }
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

export async function getRaceCounter(signer) {
    if (!signer) {
        console.warn('No signer found');
    }
    //const bettingAddress = addressesConst.bettingAddress;
    //const bettingContract = new ethers.Contract(bettingAddress, ABI, signer);
    console.log('Calling contract for totalBetAmount');
    try {
        //return await bettingContract.getAmounts()
        return 1;
        // eslint-disable-next-line no-unreachable
    } catch (err) {
        console.warn(err);
    }
    return 0;
}
