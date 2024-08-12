// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RonxRegistration {
    address public owner;

    struct User {
        string firstName;
        string lastName;
        string email;
        string password;
        string profilePic; // Added profile picture variable
        string userId;
        address walletAddress;
        string referralLink; // Added referral link variable
    }

    mapping(address => User) public users;
    address[] public userAddresses;

    event UserRegistered(address indexed walletAddress, string userId, string referralLink);

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    function registerUser(string memory _firstName, string memory _lastName, string memory _email, string memory _password, string memory _profilePic) public payable {
        require(bytes(users[msg.sender].userId).length == 0, "User already registered.");
        require(msg.value == 25 ether, "Registration requires at least 25 Ether.");

        string memory userId = generateUserId();
        string memory referralLink = generateReferralLink(userId);

        users[msg.sender] = User({
            firstName: _firstName,
            lastName: _lastName,
            email: _email,
            password: _password,
            profilePic: _profilePic, // Store profile picture
            userId: userId,
            walletAddress: msg.sender,
            referralLink: referralLink // Store referral link
        });

        userAddresses.push(msg.sender);
        payable(owner).transfer(msg.value);
        emit UserRegistered(msg.sender, userId, referralLink);
    }

    function generateUserId() internal view returns (string memory) {
        if (userAddresses.length == 0) {
            return "1000001"; 
        } else {
            string memory lastUserId = users[userAddresses[userAddresses.length - 1]].userId;
            uint256 lastUserIdInt = stringToUint(lastUserId);
            uint256 newUserIdInt = lastUserIdInt + 1;
            return toString(newUserIdInt);
        }
    }

    function generateReferralLink(string memory userId) internal pure returns (string memory) {
        return string(abi.encodePacked("https://ronxplatform.com/referral/", userId));
    }

    function stringToUint(string memory s) internal pure returns (uint256) {
        bytes memory b = bytes(s);
        uint256 result = 0;
        for (uint i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                result = result * 10 + (uint8(b[i]) - 48);
            }
        }
        return result;
    }

    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function getAllUsers() public view returns (User[] memory) {
        User[] memory allUsers = new User[](userAddresses.length);
        for (uint i = 0; i < userAddresses.length; i++) {
            allUsers[i] = users[userAddresses[i]];
        }
        return allUsers;
    }

    function getUserByUserId(string memory _userId) public view returns (User memory) {
        for (uint i = 0; i < userAddresses.length; i++) {
            if (keccak256(abi.encodePacked(users[userAddresses[i]].userId)) == keccak256(abi.encodePacked(_userId))) {
                return users[userAddresses[i]];
            }
        }
        revert("User ID not found.");
    }
}
