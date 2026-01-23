$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
function prompt {
    $path = "$(Get-Location)" -replace '\\', '\\'
    $path = $path + '\\'

    $git_branch = ""

    function Isgit {
        # checkout Isgit
        function IsIngit {
            git rev-parse | Out-Null
            if($?) {
                return "$(git branch --show-current --no-color)"
            }
        }

        $git_branch = IsIngit
        # $status = git status | Out-String
        # if (($status -like "*<file>*") -and ($status -like "*use*")){
        #     $git_branch = $git_branch + "*"
        # }
        # if ($status -like "*committed*" -and !($status -like "*add*")){
        #     $git_branch = $git_branch + "+"
        # }
        return $git_branch
    }

    $git_branch = Isgit
    Write-Host -NoNewline "($Env:CONDA_DEFAULT_ENV) " -ForegroundColor Yellow
    Write-Host -NoNewline "$path " -ForegroundColor Green 
    Write-Host "$git_branch" -ForegroundColor Red
    return ">> "
}
