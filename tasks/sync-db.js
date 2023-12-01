let times = 0;

const syncDb = () => {
    times++;
    console.log('Tick cada 5 seg', times);

    return times;
}

module.exports = {
    syncDb
}