#%%

import pandas as pd

#%%

df = pd.read_excel('Car_Insurance_Claim.xlsx')

#%%
df.isnull().values.any()

#%%
print(df["ID"].duplicated().sum())   # nombre de doublons
print(df[df["ID"].duplicated(keep=False)].sort_values("ID")) 


# %%
print(df.dtypes)

#%%
binary_cols = [
    "Single Parent?",
    'Marital Status',
    "Red Car?",
    "License Revoked",
    "Claims Flag (Crash)"
]

for col in binary_cols:
    df[col] = df[col].map({"Yes":1, "No":0})
# %%
df.columns = (
    df.columns
    .str.lower()
    .str.replace(" ", "_")
    .str.replace("?", "")
    .str.replace("(", "")
    .str.replace(")", "")
)
# %%
df.columns
# %%
df.to_csv("claims_clean.csv", index=False)

