#  Weft

* Version 0.1 17/07/2019

Weft is a framework designed to allow a Cocoa application to dynamically create interactive user interfaces at runtime. It uses an XML based syntax. In this it has things in common with things like Pashua and Cocoa Dialog (although the use case for those tools is different) and syntactically will not be a mile from things like XUL and XAML although simpler and more limited in application.

Weft is part of Project Mentat.

That Weft allows automatic layout is down to using NSStackView.

## Example

    <window title='Weft Test Window' width='640' height='480'>
      <hstack insets='20,20,20,20'>
        <textfield label='Name' width='50' id='name' placeholder='Matt Mower'></textfield>
        <button gravity='leading' id='main' clicked='invokeScript:myapp/set-name' title='Ok'></button>        
      </hstack>
    </window>

