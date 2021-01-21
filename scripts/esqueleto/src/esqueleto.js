const fs = require("fs");

const pathInputFile = "/mnt/c/dev/workspaceMateus/sql/scripts/esqueleto/example/input.sql"
const pathOutPutFile = "/mnt/c/dev/workspaceMateus/sql/scripts/esqueleto/example/output.sql"
const wordWhiteList = ["BEGIN", "FOR", "END LOOP", "LOOP", "EXCEPTION", "END;", "IN"];


function readFile(path){
    return fs.readFileSync(path, 'utf8');
}


async function createFile(path, content){
    fs.writeFile(path,
                 content,
         (err) => {
                    if (err) throw err;
                    console.log('O arquivo foi criado!');
    });
}


async function cleanLine(line){

    if(line.includes("--")){
        return line + "\n";
    }

    let wordList = line.split(" ");

    for(let word of wordList){
        let wordUpper = word.toUpperCase();

        if(!wordWhiteList.includes(wordUpper)){
            line = line.replace(word, "");
        }
    }

    if(line){
        return line + "\n";
    }

    return line;
}


async function main(){

    let finalContent = "";
    let data = readFile(pathInputFile);

    console.log(JSON.stringify(data));

    let content = data.split(/\r?\n/);

    for(let line of content){

        let newLine = await cleanLine(line);
        finalContent = finalContent + newLine;
    }

    finalContent = finalContent.replace(/(^[ \t]*\n)/gm, "");

    console.log(JSON.stringify(finalContent));

    await createFile(pathOutPutFile, finalContent);
}


main();
