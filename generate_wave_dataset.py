import pandas as pd
from faker import Faker
import numpy as np
from datetime import datetime, timedelta

# Initialize Faker and set seeds for reproducibility
fake = Faker()
Faker.seed(42)
np.random.seed(42)

# Generate users (1,000 users)
users = pd.DataFrame({
    "u_id": [fake.uuid4() for _ in range(1000)]
})
users.to_csv("users.csv", index=False)

# Generate wallets (1,000 wallets, linked to users)
wallets = pd.DataFrame({
    "wallet_id": [fake.uuid4() for _ in range(1000)],
    "u_id": users["u_id"].sample(1000, replace=True).values,
    "ledger_location": np.random.choice(["Senegal", "Ghana", "Nigeria", "Cote d'Ivoire"], 1000, p=[0.4, 0.3, 0.2, 0.1])
})
wallets.to_csv("wallets.csv", index=False)

# Generate transfers (1,000 transactions)
transfers = pd.DataFrame({
    "transfer_id": range(1, 1001),
    "u_id": users["u_id"].sample(1000, replace=True).values,
    "source_wallet_id": wallets["wallet_id"].sample(1000, replace=True).values,
    "send_amount_scalar": np.random.uniform(1000, 15000000, 1000).round(2),  # Up to 15M CFA
    "send_amount_currency": np.random.choice(["CFA", "USD", "EUR"], 1000, p=[0.7, 0.2, 0.1]),
    "when_created": [fake.date_time_between(start_date="-1y", end_date="now") for _ in range(1000)],
    "kind": np.random.choice(["peer_to_peer", "merchant_payment", "bill_payment"], 1000, p=[0.5, 0.3, 0.2])
})
transfers.to_csv("transfers.csv", index=False)

# Generate agents (1,000 agents)
agents = pd.DataFrame({
    "agent_id": [fake.uuid4() for _ in range(1000)],
    "city": np.random.choice(["Dakar", "Accra", "Lagos", "Abidjan"], 1000, p=[0.4, 0.3, 0.2, 0.1]),
    "country": np.random.choice(["Senegal", "Ghana", "Nigeria", "Cote d'Ivoire"], 1000, p=[0.4, 0.3, 0.2, 0.1])
})
agents.to_csv("agents.csv", index=False)

# Generate agent transactions (1,000 transactions)
agent_transactions = pd.DataFrame({
    "atx_id": range(1, 1001),
    "agent_id": agents["agent_id"].sample(1000, replace=True).values,
    "amount": np.random.uniform(-50000, 50000, 1000).round(2),  # Positive for withdrawals, negative for deposits
    "when_created": [fake.date_time_between(start_date="-1y", end_date="now") for _ in range(1000)]
})
agent_transactions.to_csv("agent_transactions.csv", index=False)

print("Synthetic datasets saved: users.csv, wallets.csv, transfers.csv, agents.csv, agent_transactions.csv")