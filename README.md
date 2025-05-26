# Simian Examples for MATLAB

Simian GUI offers a low-code solution for creating web apps using Python, MATLAB, and Julia, expediting development and ensuring a smooth journey from concept to production. By leveraging accessible web technologies such as form.io, DataTables, and Plotly, it facilitates the creation of apps for complex tasks like calculations and data visualization.
 
With an intuitive two-pillar approach to app development, Simian GUI simplifies the process of building and adding interaction, offering options like an app builder or low-code programmatic approach. It also provides utilities to easily manage web events and backend functionalities, eliminating the need for tailored API definitions.
 
During runtime, the Simian frontend renders the defined web app directly from Python, MATLAB, or Julia code in the web browser, without requiring front-end developer involvement. This streamlined workflow allows users to craft and deploy apps locally with ease, making Simian GUI a comprehensive solution for web app development from inception to production.

## Getting Started

### Dependencies

* Simian GUI runs and is tested on MATLAB `R2022a` to `R2024b`.

### Installing

* Download Simian GUI for MATLAB  from the [download page](https://downloads.simiansuite.com/matlab/).

* Unzip the archive.

* Run `install.p` to add the required folders to the MATLAB path.  
    <small>This script does not save the path, so it must be run in each time MATLAB is started.</small>

### Running Examples

#### Online

Example web apps are deployed at the [Simian Web Apps Demo portal](https://demo01.simiansuite.com/)

#### Local

* **Ball Thrower**: this example uses the `ode45` solver to calculate the trajectory of a ball being thrown.
    ```
    import simian.local_v3_2_0.*
    Uiformio("simian.examples_v3_2_0.ballthrower", WindowTitle="Ball Thrower")
    ```
    See [Example](https://doc.simiansuite.com/simian-gui/example.html) in the documentation for more details.

### Building an App

* A Simian Web App is a module containing two functions: `gui_init` to define the form and `gui_event` to handle events.
    *guiInit.m*
    ```matlab
    function payload = guiInit(metaData)
        import simian.gui_v3_2_0.*;

        % Create a form and add it to the payload.
        form            = Form();
        payload.form    = form;
        
        % Set a logo and title.
        payload.navbar.logo = "favicon.ico";
        payload.navbar.title = "Hello, World!";
    end
    ```
    *guiEvent.m*
    ```matlab
    function payload = guiEvent(metaData, payload)
        import simian.gui_v3_2_0.*;

        % Process the events.
    end
    ```

* See the [Hello world](https://doc.simiansuite.com/simian-gui/setup/hello.html) example in the documentation for how to program a Simian Web App.

## Help

In case of issues or questions, please see the [issue tracker](https://github.com/Simian-Web-Apps/Issue-Tracker).

## Contributing

Any contributions to the examples are greatly appreciated.

If you have an example that you would like to share, please fork the repo and create a pull request. Don't forget to give the project a star! Thanks again!

1. Fork the Project

2. Create your Feature Branch (git checkout -b feature/AmazingExample)

3. Commit your Changes (git commit -m 'Add some Amazing Example')

4. Push to the Branch (git push origin feature/AmazingExample)

5. Open a Pull Request

## Authors

* [MonkeyProof Solutions](https://monkeyproofsolutions.nl)

## Version History

See the [Release notes](https://doc.simiansuite.com/simian-gui/release_notes.html) in the documentation for the version history.

## License

The Simian Examples are licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

* [Form.io](https://form.io)
* [Plotly](https://plotly.com)
* [DataTables](https://datatables.net/)
* [Pywebview](https://pywebview.flowrl.com/)
