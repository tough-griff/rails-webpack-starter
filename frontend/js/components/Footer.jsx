import cx from 'classnames';
import pluralize from 'pluralize';
import React, { Component, PropTypes } from 'react';
import { Link } from 'react-router';

/**
 * Manages routing using ReactRouter.Link, as well as renders a
 * 'Clear complete' button and complete tasks counter.
 *
 * @todo we pass `todosFilter` to this component to trigger a re-render when the
 *   todosFilter changes. This allows `Link`'s `activeClassName` to work
 *   correctly. Is this always necessary?
 */
export default class Footer extends Component {
  static propTypes = {
    canDrop: PropTypes.bool.isRequired,
    completeCount: PropTypes.number.isRequired,
    connectDropTarget: PropTypes.func.isRequired,
    incompleteCount: PropTypes.number.isRequired,
    isOver: PropTypes.bool.isRequired,
    maxIndex: PropTypes.number.isRequired,
    onClick: PropTypes.func.isRequired,
    onDrop: PropTypes.func.isRequired,
    todosFilter: PropTypes.oneOf(['all', 'active', 'completed']).isRequired,
  };

  renderClearButton() {
    const { completeCount, onClick } = this.props;
    if (!completeCount) return null;

    return (
      <button
        className="clear-completed"
        onClick={onClick}
      >
        Clear complete
      </button>
    );
  }

  renderTodoCount() {
    return (
      <span className="todo-count">
        {pluralize('task', this.props.incompleteCount, true)} remaining.
      </span>
    );
  }

  render() {
    const { canDrop, isOver, connectDropTarget } = this.props;
    const className = cx('footer', {
      over: isOver && canDrop,
    });

    return connectDropTarget(
      <footer className={className}>
        {this.renderTodoCount()}
        <ul className="filters">
          <li><Link activeClassName="selected" to="/all">All</Link></li>
          <li><Link activeClassName="selected" to="/active">Active</Link></li>
          <li><Link activeClassName="selected" to="/completed">Completed</Link></li>
        </ul>
        {this.renderClearButton()}
      </footer>
    );
  }
}
