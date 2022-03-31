/* tslint:disable */
pragma solidity >0.6.4;
pragma experimental ABIEncoderV2;
//compiler 0.7.0
//SPDX-License-Identifier:MIT

contract Betting{
    uint256 public minimumBet;
    uint256[10] public totalBets;
    uint256 public numberOfBets;
    uint256 public maxAmountOfBets = 1000;

    address payable[] public players;

    string[] public teamNames;
    string public teamWinner;

    struct Player {
        uint256 amountBet;
        string teamSelected;
    }

    // Address of the player and => the user info
    mapping(address => Player) public playerInfo;


    constructor() public {
        minimumBet = 100000000000000;
        teamNames = ["AlfaRomeo", "AlphaTauri", "Alpine", "AstonMartin", "Ferrari",
    "Haas","McLaren", "Mercedes","RedBull","Williams"];
    }

    function getTeamName(uint256 index) public view returns (string memory) {
        return teamNames[index];
    }

    function getAllTeamNames() public view returns (string[] memory) {
        return teamNames;
    }

    function random(uint number) public view returns (uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,
        msg.sender))) % number;
    }

    function set_winner() public payable{
    // extract random index of winner
    // create list of 10 team makers
        teamWinner = teamNames[random(teamNames.length)];
    }

    function get_winner() public view returns (string memory) {
        return teamWinner;
    }

    function checkPlayerExists(address player) public view returns (bool){
        for(uint256 i = 0; i < players.length; i++){
            if(players[i] == player) return true;
        }
        return false;
    }

    //This function includes the player to the game if he hasn't played and his bet is higher than the min. bet.
    function bet(string memory _teamSelected) public payable {
        //The first require is used to check if the player already exist
        require(!checkPlayerExists(msg.sender));

        //The second one is used to see if the value sended by the player is
        //Higher than the minum value
       // require(msg.value >= minimumBet);

        //We set the player informations : amount of the bet and selected team
        playerInfo[msg.sender].amountBet = msg.value;
        playerInfo[msg.sender].teamSelected = _teamSelected;

        //then we add the address of the player to the players array
        players.push(msg.sender);

        //at the end, we increment the stakes of the team selected with the player bet
        for (uint i=0; i<teamNames.length; i++){
            if (keccak256(abi.encodePacked(_teamSelected)) == keccak256(abi.encodePacked(teamNames[i]))){
                totalBets[i] += msg.value;
            }
        }
    }

    function distributePrizes() public {
        address payable[1000] memory winners;
        //We have to create a temporary in memory array with fixed size
        //Let's choose 1000
        uint256 count = 0; // This is the count for the array of winners
        uint256 LoserBet = 0; //This will take the value of all losers bet
        uint256 WinnerBet = 0; //This will take the value of all winners bet
        address add;
        uint256 bet_amount;
        address payable playerAddress;
        //We loop through the player array to check who selected the winner team
        for(uint i = 0; i < players.length; i++){
            playerAddress = players[i];
            //If the player selected the winner team
            //We add his address to the winners array
            if(keccak256(abi.encodePacked(playerInfo[playerAddress].teamSelected)) == keccak256(abi.encodePacked(get_winner()))){
                winners[count] = playerAddress;
                count++;
            }
        }
        //We define which bet sum is the Loser one and which one is the winner
        for(uint i=0; i<teamNames.length; i++){
            if (keccak256(abi.encodePacked(teamNames[i])) == keccak256(abi.encodePacked(get_winner()))){
                WinnerBet = totalBets[i];
            }else{
                LoserBet += totalBets[i];
            }
        }

        //We loop through the array of winners, to give ethers to the winners
        for(uint j = 0; j < count; j++){
            // Check that the address in this fixed array is not empty
            if(winners[j] != address(0))
                add = winners[j];
                bet_amount = playerInfo[add].amountBet;
                //Transfer the money to the user
                winners[j].transfer((bet_amount*(10000+(LoserBet*10000/WinnerBet)))/10000 );
        }

        delete playerInfo[playerAddress]; // Delete all the players
        delete players[players.length-1]; // Delete all the players array
        LoserBet = 0; //reinitialize the bets
        WinnerBet = 0;
        delete totalBets[totalBets.length-1];//why you want to delete the value of the last item in this array?

    }

    function getAmounts() public view returns(uint256[] memory){
        uint256[] memory totalAmounts= new uint256[](totalBets.length);
        for (uint i=0; i<totalBets.length; i++){
            totalAmounts[i] = totalBets[i];
        }
        return totalAmounts;
    }

    //This function does the same work of getAmounts. We can use either of them according to the tests.
    function getAmounts2() public view returns(uint256[10] memory){
        return totalBets;
    }

}
