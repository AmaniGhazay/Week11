pragma solidity ^0.8.0;

contract Bank{

    mapping(address=>uint) public account_balance;


    function get_balance() external view returns(uint){
       return account_balance[msg.sender];
    }

    function transfer(address recipient , uint amount) public {
        account_balance[msg.sender] -= amount;
        account_balance[recipient] += amount;
    }

    function withdrawl(uint amount) external {
        account_balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    receive () external payable {
        account_balance[msg.sender] += msg.value;
    }

}
  // Todo:

    // register account method 
    // onlyRegistered() modifier [done]
    // new mapping for KYC 
    // Kyc struct 
    // number of account 


contract BankExt {

  

    uint number_of_accounts;

    mapping(address=>uint) public account_balance;
    mapping(address=>uint) public account_info_map;

    // require(account_balance[msg.sender]>=0)

  
    struct BankAccountRecord {//2
        uint account_number; 
        string fullName ;
        string profession ;
        string DataOfBrith ;
        address wallet_addr ;
        string customer_addr; 
    }

    BankAccountRecord[] bankAccountRecords ; 

    function register_account(
            string memory fullName_,
            string memory profession_,
            string memory DataOfBrith_,
            string memory customer_addr_) external {

            require(account_info_map[msg.sender] == 0 , "Account already registered");
            
            bankAccountRecords.push(
                BankAccountRecord({
                    account_number:++number_of_accounts,
                    fullName:fullName_,
                    profession:profession_,
                    DataOfBrith:DataOfBrith_,
                    wallet_addr:msg.sender,
                    customer_addr: customer_addr_
                    }));

            account_info_map[msg.sender] = number_of_accounts;
        }

    modifier onlyRegistered() {
        require(account_info_map[msg.sender] > 0 , "User not Register, plaese Register to use this method ");
        _;
    }

    function get_balance() external view onlyRegistered returns(uint){
        return account_balance[msg.sender];
    }

    function transfer (uint amount, address acctToTransferTo) external onlyRegistered{
        // require(account_balance[msg.sender]>=amount);
        account_balance[msg.sender] -= amount;
        account_balance[acctToTransferTo] += amount;
    }

    // function bankBalance() external view returns(uint){return address(this).balance;}

    function withdrawl(uint amount) external {
        account_balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    receive () external payable {
        account_balance[msg.sender] += msg.value;
    }



}
