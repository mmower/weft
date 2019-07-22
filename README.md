#  Weft
*Version 0.9 - 22nd July 2019*

Weft is a framework designed to be embedded into a Cocoa application to allow the application to create custom user interfaces at run-time. The primary use-case is to allow a user-written script to create a custom form that can capture user data and return it to the script. Weft is a component of **Project Mentat**.

The Weft framework includes a `WeftRunner` class that accepts a UI definition as an XML string. Weft defines an XML syntax for creating elements such as textfields and buttons. The `WeftRunner` returns an  `NSWindowController` instance that can display the UI, talk to the host application via a `WeftApplicationDelegate` protocol, and provide the data from form elements to the host application when the window is dismissed.

See the [Element Guide](#element-guide) for description of the Weft XML syntax.

## Example

For a more complete example see the [WeftHarness](https://github.com/mmower/weft/tree/master/WeftHarness) target in the Xcode project. Clone the project and run WeftHarness for a live demo. 

    <window title='Weft Test Window' width='640' height='120'>
      <col insets='20,20,20,20'>
        <row insets='10,10,10,10'>
          <label width='65' title='Name:'/>
          <textfield id='name' placeholder='John. Q. Public'/>
        </row>
        <row insets='10,10,10,10'>
          <label width='65' title='Password:'/>
          <password id='password'/>
        </row>
        <row insets='10,10,10,10'>
          <checkbox title='Remember Me' id='remember'/>
          <popupbutton id='length' choices='1 week,2 weeks,1 month' default='2 weeks'/>
          <ok/>
        </row>
      </col>
    </window>
    
[![Watch the video](https://img.youtube.com/vi/D50xPhEbEHk/maxresdefault.jpg)](https://youtu.be/D50xPhEbEHk)

## <a name='getting-started'>Getting Started</a>

### <a name='installation'>Installation</a>

Weft is intended to be installed using the [Carthage](https://github.com/Carthage/Carthage) package manager. See the section on [installing frameworks into your application](https://github.com/Carthage/Carthage#getting-started). 

Add the following to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

    github "https://github.com/mmower/weft"
    
Then run `carthage update --platform macOS` to download and build the framework before adding it to your application as described above.

Alternatively you can download and build the framework manually and copy it into your application, updating the embedded binaries section of your target in Xcode.
    
## <a name='class-categories-and-protocols-guide'>Class, Categories, & Protocols Guide</a>

Weft defines a number of classes, categories, and protocols that an application hosting Weft needs to interact with.

The `WeftRunner` class creates a `WeftApplication` from an XML string defining the interface. The definition is compiled into a tree of `NSView` objects representing the user-interface which in turn is wrapped in an `NSWindow` and returned via an `NSWindowController` that the host application can use to manage the UI. By implementing the methods of the `WeftApplicationDelegate` protocol the host application can respond to changes in the UI (e.g. buttons being pushed), the user dismissing the UI, and obtain the data stored in the data elements of the UI (e.g. textfield contents & checkbox states).

### WeftRunner (`class`)

The `WeftRunner` class is the host applications interface to the Weft framework. Each `WeftRunner` is responsible for managing an `NSWindow` and returns an `NSWindowController` to the host application by which it can control the display of the user interface.

#### Methods

##### `- (instancetype)initWithSource:(NSString *)source delegate:(id<WeftApplicationDelegate>)delegate`

Creates an instance of `WeftRunner` to manage a `WeftApplication` defined by the `source` XML string. Associates a `WeftApplicationDelegate` provided by the host app to receive callbacks from the `WeftApplication` during the operation of the user interface.

##### `- (NSWindowController *)run`

Creates an `NSWindow` and `NSWindowController` to operate the user interface. The window controller instance is returned to the 

##### `- (void)close`

### WeftApplication (`class`)

The `WeftApplication` class is used internally to represent the definition of the interface parsed from the source XML and the `NSView` elements that are used represent them in the live interface. Host applications do not create `WeftApplication` instances as this is the job of the `WeftRunner`. An instance of `WeftApplication` is passed to all delegate methods.

The lifecycle of `WeftApplication` instances is governed by the `WeftRunner`. The host application should not need to keep a references to `WeftApplication` itself. The result of calling methods on `WeftApplication` after the UI has been dismissed are undefined.

#### Methods

##### <a name="weftapplication-methods-values">`- (NSDictionary *)values`</a>

The `values` message can be sent to a `WeftApplication` to retrieve the current value of all data elements in the interface. The returned dictionary usese the `id` attributes of these elements as keys referencing appropriate attribute values (e.g. an `NSString` for the value of an `NSTextfield` specified by a `<textfield>` element).

### WeftApplicationDelegate (`protocol`)

`WeftApplicationDelegate` defines 1 mandatory and 3 optional methods for allowing the host and `WeftApplication` to interact.

#### Mandatory methods

##### `- (void)weftApplication:(WeftApplication *)app complete:(BOOL)ok`

When the user clicks on the button represented by an `<ok>` or `<cancel>` element the `WeftApplication` sends this message to its delegate. If an `<ok>` element was pressed the `complete:` argument is `YES` otherwise it is `NO`. The host is responsible for calling `-close` on the provided `NSWindowController` to dismiss the interface.

#### Optional methods

##### `- (void)weftApplication:(WeftApplication *)app buttonPushed:(NSButton *)button`

When the user clicks on a button represented by a `<button>` element the `WeftApplication` sends this message to its delegate. 

### NSView+Weft (`category`)

Weft defines an `NSString *` property `elementId` on `NSView`.

#### <a name="nsview-methods-element-id">`- (NSString *)elementId`</a>

Returns the value that was specified using the `id` attribute that is mandary on data elements in Weft XML. For example `id` is a mandary attribute of the `<textfield>` element. This allows the host application to relate the elements defined in the source to the dynamically generated  `NSView` instances that represent them in the user interface. The host application code should not need to call the associated `-setElementId:` method itself, doing so may cause problems.

## <a name="element-guide">Element Guide</a>

### <a name="structural-elements">Structural Elements</a>

The structural elements create the outline of the user interface. All Weft interfaces start with a `<window>` which, by default, contains a `col` with no insets and using a distribution of `fillequal` into which further elements can be places. This simplifies in that the user does not need to specify a container for elements. Further `<row>` and `<col>` elements may be used to structure the interface into rows and columns as required.

#### <a name="window-element">\<window\></a>

##### Example

A `<window>` element specifies the top-level window and contains all other elements.

    <window title="Weft Demo" width="640" height="480">
      …
    </window>
    
##### Attributes
    * title: Title for the window
    * width: initial width of the window (this may be changed if the layout ends up wider)
    * height: initial height of the window (this may be changed if the layout ends up taller)
    
#### <a name="row-element">\<row\></a>

A `<row>` organises its contents horizontally. Internally a row is represented via an `NSStackView` whose `orientation` property is set to `NSUserInterfaceLayoutOrientationHorizontal`.

##### Attributes
  * `insets` - a series of values used as a margin between the edge of the row and its contents. Specified as `top`, `left`, `bottom`, `right`
  * `distribution` - controls how contents are distributed across the width of the row. Valid values are `equalcentering`, `equalspacing`, `fill`, `fillequally`, `fillproportionally`, `gravity`

### <a name="row-element">\<col\></a>

A `<col>` organises its contents vertically. Internally a col is represented via an `NSStackView` whose `orientation` property is set to `NSUserInterfaceLayoutOrientationVertical`.

##### Attributes

A col organises its contents as a vertical stack of elements.

### <a name="data-elements">Data Elements</a>

Data elements represent the input controls that appear within the UI layout and have values that can be obtained via the [`- values`](#weftapplication-methods-values) method.

#### Mandatory Attributes

The following attributes are mandatory for all data elements:

* `id`: a unique identifier for the element that will be associated with its correspdonding `NSView` instance via the [`-elementId`](#nsview-methods-element-id) method.

#### Optional Attributes

The following attributes are supported for all data elements but are optional:

* `gravity`: when the data element is placed into a `<col>` or `<row>` whose distribution is set to `gravity` then this attribute specifies the gravity area into which the control will be placed. Valid values are `leading`, `center`, and `trailing` for `<row>` elements and `top`, `center`, and `bottom` for `<col>` elements.


### <a name="textfield-element">\<textfield\></a>

A `<textfield>` creates an `NSTextField`  that supports a single line of editable text.

##### Attributes
* `default`: default value to user for the textfield
* `placeholder`: value to be displayed in textfield if there is no value
* `tooltip`:  value to be displayed as a tooltip
* `disabled`: set to `1` to disable this control

### <a name="textbox-element">\<textbox\></a>

A `<textbox>` creates an `NSTextView` that supports editing a longer text.

##### Attributes

### <a name="password-element">\<password\></a>

A `<password>` creates an `NSSecureTextField` that allows for editing sensitive values such as passwords and prevents them appearing on screen.

##### Attributes

### <a name="button-element">\<button\></a>

A `<button>` element specifies a push-button (`NSButton`) control. 

##### Attributes
* `id`: unique identifier for the button. Will be sent to the delegate.

### <a name="ok-element">\<ok\></a>

An `<ok>` element specifies an **Ok** button. It is a special type of button that, when pushed, sends the `WeftApplicationDelegate` a message `- (void)weftApplication:(WeftApplication *)app complete:(BOOL)ok` passing `YES` as the `complete` value.

##### Attributes
* `title`: the title to appear on the ok button

### <a name="cancel-element">\<cancel\></a>

A `<cancel>` element specifies a **Cancel** button. It is a special type of button that, when pushed, sends the `WeftApplicationDelegate` a message `- (void)weftApplication:(WeftApplication *)app complete:(BOOL)ok` passing `NO` as the `complete` value.

##### Attributes

### <a name="checkbox-element">\<checkbox\></a>

A `<checkbox>` element specifies an on/off checkbox control.

##### Attributes

* `id`: unique identifier for the checkbox. Will be used as a data key
* `title`: string for the label associated with the checkbox
* `disabled`: specify a value of `1` to have the control be disabled
* `gravity`: if in a `<row>` or `<col>` using the `gravity` distribution specify a value of `leading`, 

### <a name="radio-element">\<radio\></a>

##### Attributes

### <a name="popupbutton-element">\<popupbutton\></a>

##### Attributes

### <a name="datepicker-element">\<datepicker\></a>

##### Attributes

## Acknowledgements

Philosophically Weft was inspired by [Pashua](https://www.bluem.net/en/projects/pashua/) and [Cocoa Dialog](https://cocoadialog.com/) which demonstrated that such an approach was viable. Also [XAML](https://docs.microsoft.com/en-us/dotnet/framework/wpf/advanced/xaml-overview-wpf) and [XUL](https://developer.mozilla.org/en-US/docs/Mozilla/Tech/XUL) which encouraged a need for simplicity of purpose. Weft is made possible by Apple AutoLayout and `NSStackView`.

## License

Weft is released under the MIT license, see the `LICENSE` file for details.
