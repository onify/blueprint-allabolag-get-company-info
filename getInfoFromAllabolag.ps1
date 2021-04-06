param(
	[Parameter(mandatory=$true)]
    [string]$orgnr
)

$allabolagResult = @{
    ceo = ""
    phone = ""
}

$orgnr = $orgnr.Replace("-", "")
$Driver = Start-SeFirefox -StartURL "https://www.allabolag.se/$orgnr" -Quiet

# Get company info
$ceoElement = $Driver.FindElementByXPath('//*[@id="company-card_overview"]/div[3]/div[1]/dl/dd[1]/a')
$phoneElement = $Driver.FindElementByXPath('//*[@id="company-card_overview"]/div[3]/div[2]/dl/dd[1]/a')

# Set output vars
$allabolagResult.ceo = $ceoElement.Text;
$allabolagResult.phone = $phoneElement.Text

Stop-SeDriver -Target $Driver

$allabolagResult | ConvertTo-Json -Compress