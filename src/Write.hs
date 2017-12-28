module Write where

import qualified Module
import qualified Data.List as List


wat :: Module.Model -> IO ()
wat module_ =
    writeFile (fileName module_) (Module.write module_)


fileName :: Module.Model -> String
fileName module_ =
    "./" ++ (Module.name module_) ++ ".wat"
