//V11
pragma solidity >=0.7.0 <0.7.1;
pragma experimental ABIEncoderV2;
//compiler 0.7.0
//SPDX-License-Identifier:MIT

contract Betting{
    uint256[10] public totalTeamBets;//number of TeamBets=number of teams
    uint public gamesCounter = 0;//Counts every game, increases when distributePrizes is called.

    address payable[] public players;
    address payable[5] public winnerPlayers;//Stores the winner players in each game.

    string[] public teamNamesFix;
    string[] public teamNamesQuotes;
    uint256[5] public winnersGains;//Holds a list of the gains of the winner players
    string public winningTeam;

    struct Player {
        uint256 amountBet;
        string teamSelected;
    }

    // Address of the player and => the user info
    mapping(address => Player) public playerInfo;

    constructor() {
        //TeamNamesQuotes array is used only to provide different possibilities for each team
        //and determine the winner team in the "setWinnerTeam" function with the random calculation using this array.
        teamNamesQuotes = ["alfa_romeo", "alfa_romeo", "alpha_tauri", "alpha_tauri", "alpine", "alpine", "aston_martin", "ferrari", "ferrari", "ferrari",
        "haas", "haas", "mclaren", "mercedes", "mercedes", "mercedes","redbull", "redbull", "redbull","williams"];

        teamNamesFix = ["alfa_romeo", "alpha_tauri", "alpine", "aston_martin", "ferrari",
        "haas","mclaren", "mercedes","redbull","williams"];

    }

    //For example, if you put in 10, it will generate a random number between 0-9 https://blog.finxter.com/how-to-generate-random-numbers-in-solidity/
    function random(uint number) public view returns (uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,
            msg.sender))) % number;
    }

    function getGamesCounter() public view returns (uint){
        return gamesCounter;
    }

    function getWinningTeam() public view returns (string memory) {
        return winningTeam;
    }

    function setWinningTeam() public payable{
        // generates a random index for the winner
        // given the index, get the winner team from the teamNamesQuotes array and set it as winningTeam
        winningTeam = teamNamesQuotes[random(teamNamesQuotes.length)];
    }

    // Deletes all the players
    function deletePlayerInfo() public payable{
        for(uint i = 0; i < players.length; i++){
            delete playerInfo[players[i]];
        }
    }

    function checkPlayerExists(address player) public view returns (bool){
        for(uint i = 0; i < players.length; i++){
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
        //require(msg.value >= minimumBet);//later

        //We set the player informations : amount of the bet and selected team
        playerInfo[msg.sender].amountBet = msg.value;
        playerInfo[msg.sender].teamSelected = _teamSelected;

        //then we add the address of the player to the players array
        players.push(msg.sender);

        //at the end, we increment the stakes of the team selected with the player bet
        for (uint i=0; i<teamNamesFix.length; i++){
            if (keccak256(abi.encodePacked(_teamSelected)) == keccak256(abi.encodePacked(teamNamesFix[i]))){
                totalTeamBets[i] += msg.value;
            }
        }
    }

    //returns a list with all players who have won
    function setWinnerPlayers() public payable {
        address payable playerAddress;

        //Delete all winning players from the previous game
        delete winnerPlayers;

        //We loop through the player array to determine all the players who have won.
        for(uint i = 0; i < players.length; i++){
            playerAddress = players[i];
            //If the player selected the winner team
            //We add his address to the winnerPlayers array
            if(keccak256(abi.encodePacked(playerInfo[playerAddress].teamSelected)) == keccak256(abi.encodePacked(winningTeam))){
                winnerPlayers[i]=playerAddress;
            }
        }
    }

    function resetGame() public payable {
        deletePlayerInfo(); //Delete player info at all addresses
        delete players; //Delete all the players array
        delete totalTeamBets; //Delete all the bets of the players
    }

    function distributePrizes() public payable {
        uint256 betOnWinnerTeam = 0; //winning pool
        uint256 totalBetsOnLoserTeams = 0; //loosing pool
        address add;
        uint256 bet_amount;
        gamesCounter += 1;

        //Sets the winner team with a random calculation
        setWinningTeam();

        //Sets the winner players=sets the "winnerPlayers" array
        setWinnerPlayers();

        //We define the BetOnWinnerTeam. Then, we calculate totalBetsOnLoserTeams by summing the rest
        for(uint i=0; i<teamNamesFix.length; i++){
            if (keccak256(abi.encodePacked(teamNamesFix[i])) == keccak256(abi.encodePacked(winningTeam))){
                betOnWinnerTeam = totalTeamBets[i];
            }else{
                totalBetsOnLoserTeams += totalTeamBets[i];
            }
        }
        /*
        //This is only for testing if there is a winner, this contract works:
        //The code below is only when "mercedes" is used in all teamNamesQuotes values:
        if (keccak256(abi.encodePacked(teamNamesQuotes[0]))==keccak256(abi.encodePacked("mercedes"))){
            totalBetsOnLoserTeams =50;
        }
        */

        //Delete all the gains of the winnerPlayers from the previous game before setting it in the for loop below:
        delete winnersGains;

        //Check if at least one player wins. If not, don't make a calculation for each player
        //and don't assign any values to winnerGains array
        //don't transfer any prize to the players.
        if(betOnWinnerTeam!=0){
            //We loop through the array of winnerPlayers, to give ethers to the winnerPlayers
            for(uint j = 0; j < winnerPlayers.length; j++){
                // Check that the address in this fixed array is not empty
                if(winnerPlayers[j] != address(0)){
                    add = winnerPlayers[j];
                    bet_amount = playerInfo[add].amountBet;
                    winnersGains[j] = bet_amount+(bet_amount*totalBetsOnLoserTeams/betOnWinnerTeam);
                    // Transfer the money to the user, Formula has to be adjusted
                    winnerPlayers[j].transfer(winnersGains[j]);
                }
            }
        }
        resetGame();//Empties the arrays to be used again for the next game.
    }

    //returns the total bets on each team:
    function getTotalTeamBets() public view returns (uint256[10] memory){ return totalTeamBets; }

    //returns all players
    function getPlayers() public view returns (address payable[] memory) { return players; }

    //returns all winning players
    function getWinnerPlayers() public view returns (address payable[5] memory) { return winnerPlayers; }

    //returns the gains of each winner
    function getWinnersGains() public view returns(uint256[5] memory) { return winnersGains; }

    //returns the team name in the list on index position
    function getTeamName(uint256 index) public view returns (string memory) { return teamNamesFix[index];}

    //returns the names of all teams
    function getAllTeamNames() public view returns (string[] memory) { return teamNamesFix; }

    //returns the names of all teams in teamNamesQuotes array
    function getQuotes() public view returns (string[] memory) { return teamNamesQuotes; }
}
