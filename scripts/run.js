const main = async() => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log("Contract deployed to: ", waveContract.address);
    console.log("Contract deployed by: ", owner.address);

    let actionCount;
    waveCount = await waveContract.getActionTotal();

    let waveTxn = await waveContract.wave();
    await waveTxn.wait();

    actionCount = await waveContract.getActionTotal();

    let highFiveTxn = await waveContract.connect(randomPerson).highFive();
    await highFiveTxn.wait();

    actionCount = await waveContract.getActionTotal();

    waveTxn = await waveContract.connect(randomPerson).wave();
    await waveTxn.wait();

    actionCount = await waveContract.getActionTotal();
};

const runMain = async() => {
    try {
        await main();
        process.exit(0);
    } catch {
        console.log(error);
        process.exit(1);
    }
};

runMain();