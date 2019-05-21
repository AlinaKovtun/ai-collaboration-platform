import React, { Component } from "react";

class Home extends Component {
    constructor (props){
      super(props);
      this.state = {Name: 'This is name'};
    }
    changeName = (event) => {
      this.setState({Name: event.target.value})
    }
    render() {
        return (
            <div>
                <input type='text' value={this.state.Name} onChange={this.changeName}/>
                <h1>{this.state.Name}</h1>
            </div>
            );
    }
}

export default Home;
