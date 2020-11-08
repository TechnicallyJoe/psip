BeforeAll {
    . $PSScriptRoot/../../src/lib/Get-DataFromUrl.ps1
}

Describe "Get-DataFromUrl" {
    BeforeEach {
        $dataObj = [PSCustomObject]@{
            test        = "first"
            secondLevel = [PSCustomObject]@{
                test       = "second"
                thirdLevel = [PSCustomObject]@{
                    test = "third"
                }
            }
        }
    }

    It "Can return object value that is 1 level deep" {
        Get-DataFromUrl -DataObj $dataObj -RawUrl "/test" | Should -Be "first"
    }

    It "Can return null value if object is not found 1 level deep" {
        Get-DataFromUrl -DataObj $dataObj -RawUrl "/IDontExist" | Should -BeNullOrEmpty
    }

    It "Can return object value that is 2 level deep" {
        Get-DataFromUrl -DataObj $dataObj -RawUrl "/secondLevel/test" | Should -Be "second"
    }

    It "Can return null value if object is not found 2 level deep" {
        Get-DataFromUrl -DataObj $dataObj -RawUrl "/secondLevel/IDontExist" | Should -BeNullOrEmpty
    }

    It "Can return object value that is 3 level deep" {
        Get-DataFromUrl -DataObj $dataObj -RawUrl "/secondLevel/thirdLevel/test" | Should -Be "third"
    }

    It "Can return null value if object is not found 3 level deep" {
        Get-DataFromUrl -DataObj $dataObj -RawUrl "/secondLevel/thirdLevel/IDontExist" | Should -BeNullOrEmpty
    }
}