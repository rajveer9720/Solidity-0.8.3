pragma solidity ^0.8.0;

contract UserRegistration {
   // user registration contract through data storage in blockchain in block 
   //contract field is name,email,password,phone number,address,city,state,zip code,country reffered address , wallet address to store the data in blockchain
   struct UserRegistration {
      string name;
      string email;
      string password;
      string phoneNumber;
      string addressuser;
      string city;
      string state;
      string zipCode;
      string country;
      string refferedAddress;
      string walletAddress;
   }

   UserRegistration private user;

   //function to register the user
   function registerUser(string memory name, string memory email, string memory password, string memory phoneNumber, string memory addressuser, string memory city, string memory state, string memory zipCode, string memory country, string memory refferedAddress, string memory walletAddress) public {
      user = UserRegistration(name, email, password, phoneNumber, addressuser, city, state, zipCode, country, refferedAddress, walletAddress);
   }
   //User details print function
   function printUserDetails() public view returns (string memory , string memory , string memory , string memory , string memory , string memory , string memory , string memory , string memory , string memory , string memory){
      return (user.name, user.email, user.password, user.phoneNumber, user.addressuser, user.city, user.state, user.zipCode, user.country, user.refferedAddress, user.walletAddress);
   }


   //with block number through get data user details
   function getUserDetails(uint256 blockNumber) public view returns (string memory , string memory , string memory , string memory , string memory , string memory , string memory , string memory , string memory , string memory , string memory){
      return (user.name, user.email, user.password, user.phoneNumber, user.addressuser, user.city, user.state, user.zipCode, user.country, user.refferedAddress, user.walletAddress);
   }
}