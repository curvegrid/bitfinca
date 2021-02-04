# Bitfinca: Democratising access to capital

![Bitfinca screenshot](./screenshot.png)

1. **Deployment**
    - You will need to [create a MultiBaas deployment](https://www.curvegrid.com/docs/3-0-getting-started-creating-a-multibaas-deployment/) or have an existing deployment to use this sample.
2. **API Key**
    - You will also need to [provision an API key](https://www.curvegrid.com/docs/5-1-generate-api-keys/) with membership in the `DApp User` group.
3. **Mlti Token Contract**
    - You will need to [deploy a `Bitfinca` contract and a `Token` contract](https://www.curvegrid.com/docs/4-3-deploy-a-smart-contract/) and take note of their labels. 
4. **CORS Configuration**
    - Finally, you will need to update your CORS settings by going to `Admin` then `CORS Domains` and setting up the domain of the sample app. If you are running locally this will be `http://localhost:8080` by default.

After you have configured your deployment and smart contract, please fill out the required parameters below in `main.js`:

- `BASE_URL`
- `API_KEY`
- `BITFINCA_CONTRACT` <- replace with your deployed Bitfinca contract label
- `TOKEN_CONTRACT` <- replace with your deployed FincaToken contract label
