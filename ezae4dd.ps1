<#
                              "ezae4dd"
                    ez auto encode 4 ducky drives

            Author  : Assimil8
            E-Mail  : exxxzotiq@gmail.com
            Date    : 3/6/2018
            File    : ezae4dd.ps1
            Purpose :
            +Navigates to supplied directory(dir).
            +Finds supplied .txt file within said dir for encoding.
              ~Determines if current working directory needs resources(duckencoder.jar),
              ~obtains .jar encoder if needed and places it within current dir.
            +Deletes prior inject.bin (if one exists within dir already), encoding the new one.
            +Moves freshly generated/encoded 'inject.bin' to your microSD via user input describing
             the appropriate associated drive letter.
            +Safely ejects that drive after .bin has been successfully transferred.
            Easy as that.
            +Pull the microSD, throw it in your USB, and pwn.
            Happy injecting!
            Version : 1.1
#>
$ErrorActionPreference = "Stop"
$strQuit = "Not yet, nerd."
$running_condition = $true

Do {
    "`n"
    write-Host "
                                _____     .___  .___
  ____ _____________    ____   /  |  |  __| _/__| _/
_/ __ \\___   /\__  \ _/ __ \ /   |  |_/ __ |/ __ |
\  ___/ /    /  / __ \\  ___//    ^   / /_/ / /_/ |
 \___  >_____ \(____  /\___  >____   |\____ \____ |
     \/      \/     \/     \/     |__|     \/    \/
" -ForegroundColor Cyan
      $skip_menu = $true
      Do {
      $filePath = Read-Host "Please Enter Path to Directory of Desire: `n >>> "

      if (Test-Path $filePath) {
            write-Host "-----------------------File Path Found!-----------------------"-ForegroundColor Green
            cd $filePath
            $fnf = $true
            Do {
            $fileName = Read-Host "Enter name of the file you wish to encode: `n >>> "

            if (Test-Path $fileName) {
                  write-Host "---------------------Success! File Found!---------------------"-ForegroundColor Green
                  write-Host "**SEARCHING for duckencoder.jar**"-ForegroundColor Magenta
                  $jarName = "duckencoder.jar"

                  if (Test-Path $jarName){
                      write-Host "**DETECTED duckencoder.jar**`n"-ForegroundColor Magenta
                      if (Test-Path inject.bin){
                        Remove-Item inject.bin
                        write-Host "**DELETED prior instance of inject.bin in $pwd**"-ForegroundColor Red
                      }
                      write-Host "**ENCODING newest instantiation** `n"-ForegroundColor Green
                      write-Host "________________________________________"
                      java -jar ./duckencoder.jar -i $fileName
                      write-Host "________________________________________`n"
                      write-Host "**COMPLETED encoding**`n"-ForegroundColor Green
                      $driveLetter = Read-Host "What is the letter associated with your drive? (A:, D:, E:, etc.)?"
                      write-Host "**TRANSFERRING inject.bin to $driveLetter**"-ForegroundColor Green
                      Copy-Item -path "$pwd/inject.bin" -Destination "$driveLetter/" -Container
                      Start-Sleep -s 5
                      write-Host "`n**EJECTING $driveLetter**`n"-ForegroundColor Red
                      $Eject = new-object -comObject Shell.Application
                      $Eject.NameSpace(17).ParseName("$driveLetter").InvokeVerb("Eject")
                      write-Host "************"-ForegroundColor Green
                      write-Host "************"-ForegroundColor Green
                      write-Host "**FINISHED**"-ForegroundColor Green
                      write-Host "************"-ForegroundColor Green
                      write-Host "************`n"-ForegroundColor Green
                      write-Host "Thanks for using ezae4dd!"-ForegroundColor Cyan
                      exit 0
                  } else {
                        write-Host "**OBTAINING duckencoder.jar** "-ForegroundColor Magenta
                        $uri= "https://www.dropbox.com/s/iii1wz00rxpjzmg/duckencoder.jar?dl=1"
                        $out= "$pwd/duckencoder.jar"
                        [System.Net.WebClient]$wc = new-object System.Net.WebClient
                        $wc.DownloadFileAsync($uri,$out)
                        write-Host "**COMPLETED retrieval**`n"-ForegroundColor Green
                        write-Host "**REFRESHING Script** `nRemember you can use (up) and (down) to cycle previously typed commands.`n"-ForegroundColor gray
                        continue
                    }
                }else {
                    write-Host "**NULL Item doesn't exist**"-ForegroundColor Red
                    $strQuit = Read-Host "`n Try again? (Y/N)"
                    if(($strQuit -eq "Y")-or($strQuit -eq "y")){continue} else {
                        exit 0
                    }
            }
        }while($fnf)
      }else {
         write-Host "**NULL Path doesn't exist**"-ForegroundColor Red
         $strQuit = Read-Host "Retry? (Y/N)"
        if(($strQuit -eq "Y")-or($strQuit -eq "y")){continue}else{
            exit 0
        }
        }
        }while($skip_menu)  "`n"
}while ($running_condition) #end of 'Do'
