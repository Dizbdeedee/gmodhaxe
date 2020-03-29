package gmod.gclass;


/**
    List of all possible functions to manipulate matrices. This object can be created by Matrix
**/
extern class VMatrix {
    
    /**
        Inverts the matrix. This function will not fail, but only works correctly on matrices that contain only translation and/or rotation. 
		
		Using this function on a matrix with modified scale may return an incorrect inverted matrix. 
		
		 To invert a matrix that contains other modifications, see VMatrix:Invert.
    **/
    
    public function InvertTR():Void;
    
    
    /**
        Translates the matrix by the given vector aka. adds the vector to the translation. 
		
		Postmultiplies the matrix by a translation matrix (A = AT).
		
		Name | Description
		--- | ---
		`translation` | Vector to translate the matrix by.
    **/
    
    public function Translate(translation:Vector):Void;
    
    
    /**
        Returns the absolute rotation of the matrix.
		
		`**Returns:** Absolute rotation of the matrix
    **/
    
    public function GetAngles():Angle;
    
    
    /**
        Returns the absolute scale of the matrix.
		
		`**Returns:** Absolute scale of the matrix
    **/
    
    public function GetScale():Vector;
    
    
    /**
        Gets the right direction of the matrix. 
		
		ie. The second column of the matrix, negated, excluding the w coordinate.
		
		`**Returns:** The right direction of the matrix.
    **/
    
    public function GetRight():Vector;
    
    
    /**
        Returns an inverted matrix without modifying the original matrix. 
		
		Inverting the matrix will fail if its determinant is 0 or close to 0. (ie. its "scale" in any direction is 0.) 
		
		 See also VMatrix:GetInverseTR.
		
		`**Returns:** The inverted matrix if possible, nil otherwise
    **/
    
    public function GetInverse():VMatrix;
    
    
    /**
        Returns a specific field in the matrix.
		
		Name | Description
		--- | ---
		`row` | Row of the field whose value is to be retrieved, from 1 to 4
		`column` | Column of the field whose value is to be retrieved, from 1 to 4
		
		
		`**Returns:** The value of the specified field
    **/
    
    public function GetField(row:Float, column:Float):Float;
    
    
    /**
        Sets each component of the matrix.
		
		Name | Description
		--- | ---
		`e11` | 
		`e12` | 
		`e13` | 
		`e14` | 
		`e21` | 
		`e22` | 
		`e23` | 
		`e24` | 
		`e31` | 
		`e32` | 
		`e33` | 
		`e34` | 
		`e41` | 
		`e42` | 
		`e43` | 
		`e44` | 
    **/
    
    public function SetUnpacked(e11:Float, e12:Float, e13:Float, e14:Float, e21:Float, e22:Float, e23:Float, e24:Float, e31:Float, e32:Float, e33:Float, e34:Float, e41:Float, e42:Float, e43:Float, e44:Float):Void;
    
    
    /**
        Copies values from the given matrix object.
		
		Name | Description
		--- | ---
		`src` | The matrix to copy values from.
    **/
    
    public function Set(src:VMatrix):Void;
    
    
    /**
        Checks whenever all fields of the matrix are 0.
		
		`**Returns:** If the matrix is a null matrix.
    **/
    
    public function IsZero():Bool;
    
    
    /**
        Sets the absolute translation of the matrix.
		
		Name | Description
		--- | ---
		`translation` | New translation.
    **/
    
    public function SetTranslation(translation:Vector):Void;
    
    
    /**
        Scales the absolute translation with the given value.
		
		Name | Description
		--- | ---
		`scale` | Value to scale the translation with.
    **/
    
    public function ScaleTranslation(scale:Float):Void;
    
    
    /**
        Initializes the matrix as Identity matrix.
    **/
    
    public function Identity():Void;
    
    
    /**
        Sets the up direction of the matrix. 
		
		ie. The third column of the matrix, excluding the w coordinate.
		
		Name | Description
		--- | ---
		`forward` | The up direction of the matrix.
    **/
    
    public function SetUp(forward:Vector):Void;
    
    
    /**
        Gets the forward direction of the matrix. 
		
		ie. The first column of the matrix, excluding the w coordinate.
		
		`**Returns:** The forward direction of the matrix.
    **/
    
    public function GetForward():Vector;
    
    
    /**
        Returns whether the matrix is a rotation matrix or not. 
		
		Technically it checks if the forward, right and up vectors are orthogonal and normalized.
		
		`**Returns:** Is the matrix a rotation matrix or not
    **/
    
    public function IsRotationMatrix():Bool;
    
    
    /**
        Sets the forward direction of the matrix. 
		
		ie. The first column of the matrix, excluding the w coordinate.
		
		Name | Description
		--- | ---
		`forward` | The forward direction of the matrix.
    **/
    
    public function SetForward(forward:Vector):Void;
    
    
    /**
        Sets a specific field in the matrix.
		
		Name | Description
		--- | ---
		`row` | Row of the field to be set, from 1 to 4
		`column` | Column of the field to be set, from 1 to 4
		`value` | The value to set in that field
    **/
    
    public function SetField(row:Float, column:Float, value:Float):Void;
    
    
    /**
        Rotates the matrix by the given angle. 
		
		Postmultiplies the matrix by a rotation matrix (A = AR).
		
		Name | Description
		--- | ---
		`rotation` | Rotation.
    **/
    
    public function Rotate(rotation:Angle):Void;
    
    
    /**
        Returns the absolute translation of the matrix.
		
		`**Returns:** Absolute translation of the matrix
    **/
    
    public function GetTranslation():Vector;
    
    
    /**
        Sets the absolute rotation of the matrix.
		
		Name | Description
		--- | ---
		`angle` | New angles.
    **/
    
    public function SetAngles(angle:Angle):Void;
    
    
    /**
        Sets the right direction of the matrix. 
		
		ie. The second column of the matrix, negated, excluding the w coordinate.
		
		Name | Description
		--- | ---
		`forward` | The right direction of the matrix.
    **/
    
    public function SetRight(forward:Vector):Void;
    
    
    /**
        Scales the matrix by the given vector. 
		
		Postmultiplies the matrix by a scaling matrix (A = AS).
		
		Name | Description
		--- | ---
		`scale` | Vector to scale with matrix with.
    **/
    
    public function Scale(scale:Vector):Void;
    
    
    /**
        Sets all components of the matrix to 0. This function is more efficient than setting each element manually.
    **/
    
    public function Zero():Void;
    
    
    /**
        Converts the matrix to a 4x4 table. See Matrix function.
		
		`**Returns:** The 4x4 table.
    **/
    
    public function ToTable():AnyTable;
    
    
    /**
        Modifies the scale of the matrix while preserving the rotation and translation.
		
		Name | Description
		--- | ---
		`scale` | The scale to set.
    **/
    
    public function SetScale(scale:Vector):Void;
    
    
    /**
        Returns each component of the matrix, expanding rows before columns.
		
		Name | Description
		--- | ---
		`a` | VMatrix: GetField(1, 1)
		`b` | VMatrix: GetField(1, 2)
		`c` | VMatrix: GetField(1, 3)
		`d` | VMatrix: GetField(1, 4)
		`e` | VMatrix: GetField(2, 1)
		`f` | VMatrix: GetField(2, 2)
		`g` | VMatrix: GetField(2, 3)
		`h` | VMatrix: GetField(2, 4)
		`i` | VMatrix: GetField(3, 1)
		`j` | VMatrix: GetField(3, 2)
		`k` | VMatrix: GetField(3, 3)
		`l` | VMatrix: GetField(3, 4)
		`m` | VMatrix: GetField(4, 1)
		`n` | VMatrix: GetField(4, 2)
		`o` | VMatrix: GetField(4, 3)
		`p` | VMatrix: GetField(4, 4)
    **/
    
    public function Unpack():VMatrixUnpackReturn;
    
    
    /**
        Returns whether the matrix is equal to Identity matrix or not.
		
		`**Returns:** Is the matrix an Identity matrix or not
    **/
    
    public function IsIdentity():Bool;
    
    
    /**
        Returns an inverted matrix without modifying the original matrix. This function will not fail, but only works correctly on matrices that contain only translation and/or rotation. 
		
		Using this function on a matrix with modified scale may return an incorrect inverted matrix. 
		
		 To get the inverse of a matrix that contains other modifications, see VMatrix:GetInverse.
		
		`**Returns:** The inverted matrix.
    **/
    
    public function GetInverseTR():VMatrix;
    
    
    /**
        Inverts the matrix. 
		
		Inverting the matrix will fail if its determinant is 0 or close to 0. (ie. its "scale" in any direction is 0.) 
		
		 If the matrix cannot be inverted, it does not get modified. 
		
		 See also VMatrix:InvertTR.
		
		`**Returns:** Whether the matrix was inverted or not
    **/
    
    public function Invert():Bool;
    
    
    /**
        Gets the up direction of the matrix. 
		
		ie. The third column of the matrix, excluding the w coordinate.
		
		`**Returns:** The up direction of the matrix.
    **/
    
    public function GetUp():Vector;
    
    
}


@:multiReturn extern class VMatrixUnpackReturn {
var a:Float;
var b:Float;
var c:Float;
var d:Float;
var e:Float;
var f:Float;
var g:Float;
var h:Float;
var i:Float;
var j:Float;
var k:Float;
var l:Float;
var m:Float;
var n:Float;
var o:Float;
var p:Float;

}

