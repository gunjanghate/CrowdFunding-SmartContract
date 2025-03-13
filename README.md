# 💵CrowdFunding Smart Contract 📃

## Overview
This project implements a **CrowdFunding Smart Contract** using **Solidity** on the Ethereum blockchain. It allows users to create funding campaigns, contribute ETH to campaigns, and withdraw funds once the goal is met.

## Features
- **Campaign Creation**: Users can create crowdfunding campaigns with a target amount and deadline.
- **Fund Contributions**: Contributors can send ETH to support campaigns.
- **Goal Tracking**: Funds are only transferred if the campaign reaches its goal before the deadline.
- **Owner Withdrawal**: Campaign owners can withdraw funds once the goal is met.
- **Refund Mechanism**: If the goal is not met by the deadline, contributors can withdraw their contributions.

## Smart Contract Details
### **Contract: CrowdFunding.sol**
- `Campaign` struct:
  - `owner`: Address of the campaign creator.
  - `goal`: Target amount in ETH.
  - `deadline`: Time limit for the campaign.
  - `amountRaised`: Total ETH collected.
  - `contributors`: Mapping of contributor addresses to their contributions.
- `createCampaign(uint _goal, uint _duration)`: Creates a new campaign.
- `contribute(uint _campaignId) payable`: Allows users to send ETH to a campaign.
- `withdrawFunds(uint _campaignId)`: Lets the campaign owner withdraw funds if the goal is reached.
- `refund(uint _campaignId)`: Allows contributors to reclaim funds if the goal is not met.

## How to Use 🧑‍💻
### 1. Deploy the Smart Contract
- Use **Remix IDE** or Hardhat to deploy `CrowdFunding.sol`.

### 2. Create a Campaign
- Call `createCampaign(goal, duration)` with your target ETH and deadline.

### 3. Contribute to a Campaign
- Send ETH to the contract using `contribute(campaignId)`.

### 4. Withdraw Funds (Owner)
- If the campaign goal is met, the owner calls `withdrawFunds(campaignId)`.

### 5. Refund Contributions (If Goal Not Met)
- If the deadline passes without reaching the goal, contributors can call `refund(campaignId)` to get their ETH back.

