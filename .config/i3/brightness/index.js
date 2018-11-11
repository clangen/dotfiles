const _ = require('lodash');
const { promisify } = require('util');
const argv = require('optimist').argv;
const exec = promisify(require('child_process').exec);

async function main() {
    async function query() {
        const { stdout } = await exec('xrandr --verbose | grep -i brightness');
        return stdout.split("\n")[0].trim().split(":")[1].trim();
    }

    const current = Number(await query());

    if (argv.query) {
        console.log(current);
    } else {
        async function getConnectedMonitorNames() {
            const { stdout } = await exec('xrandr -q | grep " connected "');
            return stdout.split('\n').reduce((acc, line) => {
                if(line.trim()) {
                    return [...acc, line.split(" ")[0]]
                }
                return acc;
            }, [])
        }

        async function set(value) {
            if (!_.isNumber(value) || _.isNaN(value)) {
                console.error("invalid value specified")
            } else {
                const clamped = _.clamp(value, 0.1, 1.0);
                displays = await getConnectedMonitorNames();
                displays.forEach(async (d) => {
                    await exec(`xrandr --output ${d} --brightness ${clamped}`)
                });
                console.log(clamped);
            }
        }

        if (argv.dec) {
            set(current - Number(argv.dec));
        } else if (argv.inc) {
            set(current + Number(argv.inc));
        } else if (argv.set) {
            set(Number(argv.set));
        }
    }
}

main();