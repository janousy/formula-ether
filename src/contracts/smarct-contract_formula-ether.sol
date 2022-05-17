//last_version
pragma solidity >=0.7.0 <0.7.1;
pragma experimental ABIEncoderV2;
//compiler 0.7.0
//SPDX-License-Identifier:MIT

contract Betting{
    uint256[10] public totalTeamBets;//Stores the total bets for each team
	uint public gamesCounter = 0;//Counts every game, is incremented by one when distributePrizes is called.

    address payable[] public players; //Stores the address of each player
    address payable[5] public winnerPlayers; //Stores the address of each winner player
    
    string[] public teamNamesFix; //Stores the names of the teams
    string[] public teamNamesQuotes; //Stores the team names different number of times to represent their winning probabilities
	uint256[5] public winnersGains; //Holds a list of the gains of the winner players			   
    string public winningTeam; //Stores the winning team

    struct Player {
        uint256 amountBet;
        string teamSelected;
    }
   
    // Address of the player and => the user info   
    mapping(address => Player) public playerInfo;
    
    constructor() {
        //TeamNamesQuotes array is used only to provide different winning probabilities for each team
        //and to determine the winning team in the "setWinnerTeam" function with the random calculation using this array.
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

    function setWinningTeam() public payable{
    // Generates a random index in range [0-19]
    // Given the index, gets the winning team from the teamNamesQuotes array and sets it as winningTeam
        winningTeam = teamNamesQuotes[random(teamNamesQuotes.length)];
    } 
	
	// Deletes all the players
    function deletePlayerInfo() public payable{
        for(uint i = 0; i < players.length; i++){
            delete playerInfo[players[i]]; 
        }
    }
	
	//Empties the arrays to be used again for the next game
    function resetGame() public payable {
       deletePlayerInfo(); //Deletes the player info at all addresses
       delete players; //Deletes the players
       delete totalTeamBets; //Deletes the total bets of each team
    }

	//Given the address of the player, checks if the player exists
	function checkPlayerExists(address player) public view returns (bool){
        for(uint i = 0; i < players.length; i++){
            if(players[i] == player) return true;
        }
        return false;
    }

	//This function includes the player to the game, if he hasn't played yet.
    function bet(string memory _teamSelected) public payable {

        //Check if the player already exists
        require(!checkPlayerExists(msg.sender));
        
        //Sets the player information : Amount of the bet and selected team
        playerInfo[msg.sender].amountBet = msg.value;
        playerInfo[msg.sender].teamSelected = _teamSelected;
        
        //Adds the address of the player to the players array
        players.push(msg.sender);
        
        //Increments the total bet of the selected team with the player's bet
        for (uint i=0; i<teamNamesFix.length; i++){
            if (keccak256(abi.encodePacked(_teamSelected)) == keccak256(abi.encodePacked(teamNamesFix[i]))){
                totalTeamBets[i] += msg.value;
            }
        }
    }

    //Fills the winnerPlayers array with all the players who have won 
    function setWinnerPlayers() public payable {
        address payable playerAddress;

        //Deletes all the winning players from the previous game
        delete winnerPlayers;

        //Loops through the player array to determine all the players who have won
        for(uint i = 0; i < players.length; i++){
            playerAddress = players[i];
            //If the player selected the winner team,
            //we add his address to the winnerPlayers array
            if(keccak256(abi.encodePacked(playerInfo[playerAddress].teamSelected)) == keccak256(abi.encodePacked(winningTeam))){
                winnerPlayers[i]=playerAddress;
            }
        }     
    }
        
	//Calls the functions to find the winning team, sets the winner players
	//and then calculates and distributes the prizes according to the equation described in the report of this project.
	//Lastly, the function that resets the game is called 
	//to empty all the players' information and the total bets for each team in the game.
    function distributePrizes() public payable {
        uint256 betOnWinnerTeam = 0; //winning pool
        uint256 totalBetsOnLoserTeams = 0; //loosing pool
        address add;
        uint256 bet_amount;
		gamesCounter += 1;														 

        //Sets the winning team with a random calculation
        setWinningTeam();

        //Sets the winner players=sets the "winnerPlayers" array
        setWinnerPlayers();

        //Sets the total bet of the winning team to betOnWinnerTeam. Then, calculates totalBetsOnLoserTeams by summing the rest
        for(uint i=0; i<teamNamesFix.length; i++){
            if (keccak256(abi.encodePacked(teamNamesFix[i])) == keccak256(abi.encodePacked(winningTeam))){  
                betOnWinnerTeam = totalTeamBets[i];
            }else{
                totalBetsOnLoserTeams += totalTeamBets[i];
            }
        }

        //Deletes all the gains of the winnerPlayers from the previous game before setting it in the for loop below:
        delete winnersGains;

        //Checks if at least one player wins. 
		//If not, it doesn't make a calculation for each player, 
		//it doesn't assign any values to winnerGains array
        //it doesn't transfer any prize to the players.
        if(betOnWinnerTeam!=0){
            //Loops through the array of winnerPlayers, to give ethers to the winnerPlayers
            for(uint j = 0; j < winnerPlayers.length; j++){
                //Checks if the address in this fixed array is not empty 
                if(winnerPlayers[j] != address(0)){
                    add = winnerPlayers[j];
                    bet_amount = playerInfo[add].amountBet;
                    winnersGains[j] = bet_amount+(bet_amount*totalBetsOnLoserTeams/betOnWinnerTeam);			
                    
					//Transfers the money to the winner players
                    winnerPlayers[j].transfer(winnersGains[j]);
                }																						 
            }
        }
       resetGame();//Empties the arrays to be used again for the next game.
    }
	
	//Returns the game's counter
	function getGamesCounter() public view returns (uint){ return gamesCounter; }

	//Returns the winning team
    function getWinningTeam() public view returns (string memory) { return winningTeam; }
    
    //Returns the total bets on each team
    function getTotalTeamBets() public view returns (uint256[10] memory){ return totalTeamBets; }

    //Returns all the players
    function getPlayers() public view returns (address payable[] memory) { return players; }

    //Returns all the winning players
    function getWinnerPlayers() public view returns (address payable[5] memory) { return winnerPlayers; }

    //Returns the gains of each winner
    function getWinnersGains() public view returns(uint256[5] memory) { return winnersGains; }

    //Returns the team name in the list given an index
    function getTeamName(uint256 index) public view returns (string memory) { return teamNamesFix[index];}

    //Returns the names of all teams
    function getAllTeamNames() public view returns (string[] memory) { return teamNamesFix; }

    //Returns the names of all teams in teamNamesQuotes array
    function getQuotes() public view returns (string[] memory) { return teamNamesQuotes; }
}