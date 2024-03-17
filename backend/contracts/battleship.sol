// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity >=0.8.13 <0.9.0;

import "@fhenixprotocol/contracts/FHE.sol";
import "hardhat/console.sol";

contract Battleship {
    address public player1;
    address public player2;
    address public currentPlayer;
    address public winner;
    bool public gameEnded;
    bool public gameReady;
    bool public player1Ready;
    bool public player2Ready;

    uint8 public constant BOARD_SIZE = 4; 
    uint8 public player1ShipsHit;
    uint8 public player2ShipsHit;

    // 0 = empty
    // 1 = ship
    // 2 = attacked
    euint8[BOARD_SIZE][BOARD_SIZE] public player1Board;
    euint8[BOARD_SIZE][BOARD_SIZE] public player2Board;

    event Attack(uint8 x, uint8 y, address victim, bool hit);
    event GameEnded(address winner);
    event RequiresPassed(string message);
    event emittarget(uint8 targ);

    modifier onlyPlayers() {
        require(msg.sender == player1 || msg.sender == player2, "Only players can call this function");
        _;
    }

    constructor(address _player1, address _player2) {
        player1 = _player1;
        player2 = _player2;
        currentPlayer = player1;
    }

    function placeShips(bytes calldata encryptedValue) public onlyPlayers {
        require(!gameEnded, "Game has ended");
        require(!gameReady, "Boards already set");

        // values are encoded as bits from right to left
        // 0 = empty
        // 1 = ship
        //
        // example input:
        //
        // 0010001011001100
        //
        // results in the following board:
        //
        // 0 0 1 1
        // 0 0 1 1
        // 0 1 0 0
        // 0 1 0 0
        emit RequiresPassed("REQUIRES PASSED");
        euint32 packedData = FHE.asEuint32(encryptedValue);
        euint8[BOARD_SIZE][BOARD_SIZE] storage board;
        if(msg.sender == player1 ){
            board = player1Board;
        } else {
            board = player2Board;
        }
        euint8 shipCount = FHE.asEuint8(0); 
        euint32 boardMask = FHE.asEuint32(1);
        for (uint256 i = 0; i < BOARD_SIZE * BOARD_SIZE; i++) {
          euint8 value = FHE.asEuint8(FHE.and(packedData, boardMask));
          board[i / BOARD_SIZE][i % BOARD_SIZE] = value;
          shipCount = FHE.add(shipCount, value);
          packedData = FHE.shr(packedData, boardMask);
        }
        

        // Make sure the user created 6 ships
        // FHE.req(FHE.eq(shipCount, FHE.asEuint8(4)));

        if (msg.sender == player1) {
            player1Ready = true;
        } else {
            player2Ready = true;
        }
        emit RequiresPassed("REQUIRES PASSED");
        if (player2Ready && player1Ready) {
            gameReady = true;
        }
    }

    function attack(uint8 _x, uint8 _y) public onlyPlayers {
        emit RequiresPassed("REQUIRES PASSED");
        require(gameReady, "Game not ready");
        require(!gameEnded, "Game has ended");
        require(msg.sender == currentPlayer, "Not your turn");
        emit RequiresPassed("REQUIRES PASSED");

        euint8[BOARD_SIZE][BOARD_SIZE] storage targetBoard;
        if (msg.sender == player1) {
            targetBoard = player2Board;
        } else {
            targetBoard = player1Board;
        }
        emit RequiresPassed("Board inited");

        uint8 target = FHE.decrypt(targetBoard[_x][_y]);
        emit emittarget(target);
        require(target < 2, "Already attacked this cell");

        if (target == 1) {
            if (msg.sender == player1) {
                player2ShipsHit++;
                emit Attack(_x, _y, player2, true);
            } else {
                player1ShipsHit++;
                emit Attack(_x, _y, player1, true);
            }
            if (player1ShipsHit == 4 || player2ShipsHit == 4) {
                gameEnded = true;
                winner = msg.sender;
                emit GameEnded(msg.sender);
            }
        } else {
            if (msg.sender == player1) {
                emit Attack(_x, _y, player2, false);
            } else {
                emit Attack(_x, _y, player1, false);
            }
        }
        emit RequiresPassed("Conditional is complete");
        targetBoard[_x][_y] = FHE.asEuint8(2);
        emit RequiresPassed("Board updated");
        if (currentPlayer == player1) {
            currentPlayer = player2;
        } else {
            currentPlayer = player1;
        }
        emit RequiresPassed("Player updated");
    }
}