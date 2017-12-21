module Write where

import qualified Module
import qualified Data.List as List


wat :: Module.Model -> IO ()
wat module_ =
    writeFile (fileName module_) (file module_)


fileName :: Module.Model -> String
fileName module_ =
    "./" ++ (Module.name module_) ++ ".wat"


file :: Module.Model -> String
file module_ =
    "( module " ++ (fileBody module_) ++ " )"


fileBody :: Module.Model -> String
fileBody module_ =
    ""
    